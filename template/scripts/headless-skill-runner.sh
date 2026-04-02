#!/bin/bash
# Universal headless skill runner for Life OS Mac app.
# Pre-fetches all common data sources, then runs any skill via claude -p.
#
# Usage: headless-skill-runner.sh <skillId> <repoPath>

set -uo pipefail

SKILL_ID="${1:?Usage: headless-skill-runner.sh <skillId> <repoPath>}"
REPO_DIR="${2:?Usage: headless-skill-runner.sh <skillId> <repoPath>}"

export LIFEOS_CRON=1
export PATH="$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:$PATH"

DATE=$(date +%Y-%m-%d)
TODAY=$(date '+%A, %B %-d, %Y')
YESTERDAY=$(date -v-1d '+%Y-%m-%d' 2>/dev/null || date -d yesterday '+%Y-%m-%d')

cd "$REPO_DIR"

# Pull latest changes
if [ -n "$(git status --porcelain)" ]; then
  git stash
  git pull --rebase || echo "Warning: git pull failed, continuing anyway"
  git stash pop || true
else
  git pull --rebase || echo "Warning: git pull failed, continuing anyway"
fi

# --- Pre-fetch all common data sources ---
echo "--- Pre-fetching data for /$SKILL_ID ---"

# Calendar and email (require Google API scripts from /automate setup)
CALENDAR_DATA=$(bash "$REPO_DIR/scripts/read-calendar-api.sh" 2>/dev/null || echo "CALENDAR_NOT_CONFIGURED")
EMAIL_DATA=$(bash "$REPO_DIR/scripts/read-email-api.sh" 2>/dev/null || echo "EMAIL_NOT_CONFIGURED")

# Local file data
YESTERDAY_DIGEST=$(cat "$REPO_DIR/digests/$YESTERDAY.md" 2>/dev/null || echo "NO_DIGEST")
TODAY_DIGEST=$(cat "$REPO_DIR/digests/$DATE.md" 2>/dev/null || echo "NO_EXISTING_DIGEST")
REMINDERS_DATA=$(cat "$REPO_DIR/reminders/reminders.md" 2>/dev/null || echo "NO_REMINDERS")
HEALTH_DATA=$(cat "$REPO_DIR/health/$DATE.md" 2>/dev/null || echo "NO_HEALTH_DATA")
GOALS_DATA=$(find "$REPO_DIR/goals/" -name "*.md" -exec cat {} + 2>/dev/null || echo "NO_GOALS")
JOURNAL_TODAY=$(cat "$REPO_DIR/journal/entries/$DATE"* 2>/dev/null || echo "NO_JOURNAL")
JOURNAL_YESTERDAY=$(cat "$REPO_DIR/journal/entries/$YESTERDAY"* 2>/dev/null || echo "NO_JOURNAL")

# Git activity (current repo only)
GIT_DATA=$(cd "$REPO_DIR" && git log --since="midnight" --oneline 2>/dev/null || echo "NO_GIT_DATA")

# Weather (NYC defaults, override with LIFEOS_LAT/LIFEOS_LON env vars)
LAT="${LIFEOS_LAT:-40.7128}"
LON="${LIFEOS_LON:--74.0060}"
TZ_NAME=$(readlink /etc/localtime 2>/dev/null | sed 's|.*/zoneinfo/||' || echo "America/New_York")
WEATHER_DATA=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&daily=temperature_2m_max,temperature_2m_min,weathercode&hourly=temperature_2m,weathercode&temperature_unit=fahrenheit&timezone=${TZ_NAME}&forecast_days=1" 2>/dev/null || echo "WEATHER_ERROR")

# People and work files for context
PEOPLE_FILES=$(ls "$REPO_DIR/people/"*.md 2>/dev/null | xargs -I{} basename {} .md | sort)

echo "--- Pre-fetch complete ---"

# --- Run the skill with all context ---
claude -p "Today is $TODAY ($DATE). Run /$SKILL_ID.

IMPORTANT: This is a HEADLESS session. Most MCP tools are NOT available. ALL data has been pre-fetched below. Use this data for calendar, email, health, reminders, git, and weather. Beeper MCP and Granola MCP may work — try them, but fall back to the data below if they fail.

## Calendar (Google Calendar API)
$CALENDAR_DATA

## Email (Gmail API, last 24h)
$EMAIL_DATA

## Yesterday's Digest ($YESTERDAY)
$YESTERDAY_DIGEST

## Today's Digest (if any, incremental update)
$TODAY_DIGEST

## Reminders
$REMINDERS_DATA

## Health
$HEALTH_DATA

## Goals
$GOALS_DATA

## Journal (today)
$JOURNAL_TODAY

## Journal (yesterday)
$JOURNAL_YESTERDAY

## Git Log (today)
$GIT_DATA

## Weather
$WEATHER_DATA

## People files (people/)
$PEOPLE_FILES" --permission-mode acceptEdits || echo "WARNING: /$SKILL_ID failed"

echo "--- /$SKILL_ID complete ---"
