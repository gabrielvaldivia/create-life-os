# How to Set Up Life OS

A step-by-step guide for setting up your own second brain with Claude Code.

## Prerequisites

Before you start, make sure you have:

1. **Claude Code** installed — [claude.com/claude-code](https://claude.com/claude-code)
2. **Node.js 18+** installed — run `node -v` to check
3. **Git** installed — run `git -v` to check

## Step 1: Create your Life OS

Open your terminal and navigate to where you keep projects:

```
cd ~/Documents/GitHub
```

Then run:

```
npx create-life-os
```

This creates a `life-os/` folder with everything you need.

## Step 2: Open it in Claude Code

```
cd life-os
claude
```

## Step 3: Run setup

Once Claude Code is open, type:

```
/setup
```

This starts a guided conversation that walks you through:

- **Who you are** — name, location, what you do
- **Your people** — family, close friends
- **Your life pillars** — the big areas you want to invest in (Family, Career, Health, etc.)
- **How you want Claude to talk to you** — coach, assistant, direct, gentle, etc.
- **Your goals** — what you're working toward right now (optional)

Then it'll help you connect your data sources and write your first journal entry.

## Step 4: Connect your data (optional but recommended)

During setup, you'll be guided through connecting:

### Gmail & Google Calendar
1. In Claude Code, go to **Settings** (gear icon or Cmd+,)
2. Click **Connections**
3. Click **Connect** next to Google
4. Sign in and grant access

This lets your morning briefings and digests pull from your email and calendar.

### iMessage, WhatsApp, Slack (via Beeper)
1. Download **Beeper** at [beeper.com](https://beeper.com)
2. Create an account
3. In the Beeper app, connect your messaging apps (iMessage, WhatsApp, Slack, Signal, etc.)
4. Come back to Claude Code — setup will enable the connection

All data sources are optional. Skills work with whatever you have connected.

## Step 5: Use it every day

Run any skill from Claude Code:

| Command | What it does |
|---------|-------------|
| `/morning` | Schedule, weather, what needs your attention |
| `/digest` | Captures what happened, what shipped, open loops |
| `/journal` | Write a quick journal entry |
| `/goals` | Set or review structured goals |
| `/weekly` | Preview the week ahead, check goal progress |
| `/reflect` | Trace a mistake to its root cause and patch the relevant skill |
| `/sync` | Pull from all connected sources and update your files |

## How it works

Everything is plain markdown files in a git repo:

```
life-os/
├── CLAUDE.md             ← Your system prompt (who you are, how Claude talks to you)
├── journal/entries/       ← Daily freeform journal entries
├── digests/               ← End-of-day structured recaps
├── people/                ← Notes on people in your life
├── goals/                 ← Goal tracking with quarterly milestones
├── identity/              ← Living profile, updated over time
├── work/                  ← Work-related notes
└── health/                ← Health metrics
```

**CLAUDE.md** is the brain. It tells Claude who you are, what matters to you, and how your files are organized. You can edit it anytime — just open the file and change whatever you want.

## Step 6: Automate it (optional)

Download the [Life OS Mac app](https://github.com/gabrielvaldivia/create-life-os/releases/latest/download/LifeOS-mac.zip) to run your skills on a schedule without keeping Claude Code open.

1. Unzip and move to your Applications folder
2. Open the app — it lives in your menu bar
3. Go to Settings and set your Life OS repo path
4. Your skills are discovered automatically from `.claude/commands/`
5. Schedule any skill to run daily or weekly

Then run `/automate` in Claude Code to set up Google API access so your scheduled skills can pull calendar and email data headlessly.

## Tips

- **Start small.** Just use `/journal` and `/morning` for the first week. Add more when you feel the need.
- **Edit CLAUDE.md freely.** It's your file. Update your pillars, goals, or communication preferences whenever they change.
- **Don't over-organize.** The system is designed to be simple. Resist the urge to add folders and categories.
- **If you skip days, that's fine.** Running `/digest` catches up on any missed days automatically.
- **Your data is yours.** It's just markdown files. You can read them in any text editor, back them up however you want, or move them anywhere.

## Questions?

Just ask Claude. It knows how the system works.
