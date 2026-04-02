# Life OS

A second brain, powered by Claude Code. Markdown files, git-tracked, managed through conversation.

## Getting Started

Run `/setup` in Claude Code to configure your Life OS.

## Skills

| Command | What it does |
|---------|-------------|
| `/setup` | First-time setup. Configures your Life OS from scratch. |
| `/journal` | Append a timestamped entry to today's journal. |
| `/morning` | Morning briefing. Schedule, weather, what needs your attention. |
| `/digest` | End-of-day recap. What happened, what shipped, what's still open. |
| `/weekly` | Sunday evening check-in. Preview the week ahead, check goal progress. |
| `/goals` | Set structured goals tied to your life pillars. |
| `/reflect` | Trace a mistake to its root cause and patch the relevant skill. |
| `/sync` | Pull from all connected sources and update your files. |
| `/sync-people` | Update people files from recent communications. |
| `/sync-identity` | Update your identity profile with new signals from activity. |
| `/goals-review` | Score goal progress, identify stalled goals, realign. |
| `/meeting-prep` | Briefing for an upcoming meeting so you walk in sharp. |
| `/meeting-tasks` | Extract tasks and decisions from meeting notes. |
| `/automate` | Set up the Life OS Mac app and Google API access for scheduled automation. |

## How it works

- **CLAUDE.md** is your system prompt. It tells Claude who you are, how to talk to you, and how your files are organized.
- **Skills** (`.claude/commands/*.md`) are step-by-step instructions for recurring workflows.
- **Everything is markdown.** Journal entries, digests, people notes, goals. Plain text, version controlled, yours forever.

## Philosophy

- Simple over neat. Don't over-organize.
- Start small. Add complexity when you feel the need, not before.
- Your data is yours. It's just files in a folder.
