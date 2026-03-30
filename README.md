# create-life-os

Create a second brain powered by [Claude Code](https://claude.com/claude-code).

## Quick Start

```
npx create-life-os
cd life-os
claude
> /setup
```

The setup skill walks you through everything: who you are, what matters to you, connecting your data sources, and your first journal entry. Takes about 10 minutes.

## What You Get

| Skill | What it does |
|-------|-------------|
| `/setup` | First-time setup. Configures your Life OS from scratch. |
| `/automate` | Set up macOS LaunchAgents for headless automation at 7 AM and 8 PM. |
| `/journal` | Append a timestamped entry to today's journal. |
| `/morning` | Morning briefing. Schedule, weather, what needs your attention. |
| `/digest` | End-of-day recap. What happened, what shipped, what's still open. |
| `/weekly` | Sunday evening check-in. Preview the week ahead, check goal progress. |
| `/goals` | Set structured goals tied to your life pillars. |
| `/reflect` | Trace a mistake to its root cause and patch the relevant skill. |
| `/sync` | Pull from all connected sources and update your files. |

## Data Sources

Life OS pulls from your existing tools — no new accounts needed (except Beeper for messaging):

| Source | How | What it provides |
|--------|-----|------------------|
| Gmail | Claude Connection | Email threads, sent replies for cross-referencing |
| Google Calendar | Claude Connection | Today's schedule, meeting context |
| iMessage | Beeper | Text messages, group chats |
| WhatsApp | Beeper | WhatsApp conversations |
| Slack | Beeper | Slack messages and channels |
| Weather | Open-Meteo (free) | Daily forecast, no API key needed |
| Git | Local | What you shipped today |

All sources are optional. Skills degrade gracefully — a morning briefing with just weather and yesterday's digest is still useful.

## How It Works

Everything is plain markdown files in a git repo:

```
life-os/
├── journal/entries/  — daily freeform journal entries
├── digests/          — end-of-day structured recaps
├── people/           — notes on people in your life
├── goals/            — goal tracking and progress
├── reminders/        — simple checklist of things to remember
├── identity/         — living profile, updated over time
├── work/             — work-related notes
├── health/           — health metrics
└── CLAUDE.md         — your system prompt
```

`CLAUDE.md` is the brain. It tells Claude who you are, how to talk to you, and how your files are organized. The `/setup` skill generates it from a conversation with you.

## Philosophy

- **Simple over neat.** Don't over-organize.
- **Start small.** Add complexity when you feel the need, not before.
- **Your data is yours.** Plain text, version controlled, portable.
- **The system grows with you.** Start with journaling and daily rhythms. Add the rest when it feels right.

## Requirements

- [Claude Code](https://claude.com/claude-code) installed
- Node.js 18+
- Git

## Created by

[Gabriel Valdivia](https://gabrielvaldivia.com)

## License

MIT
