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
| `/goals` | Set structured goals tied to your life pillars. |
| `/sync` | Pull from all connected sources and update your files. |

## How it works

- **CLAUDE.md** is your system prompt. It tells Claude who you are, how to talk to you, and how your files are organized.
- **Skills** (`.claude/commands/*.md`) are step-by-step instructions for recurring workflows.
- **Everything is markdown.** Journal entries, digests, people notes, goals. Plain text, version controlled, yours forever.

## Philosophy

- Simple over neat. Don't over-organize.
- Start small. Add complexity when you feel the need, not before.
- Your data is yours. It's just files in a folder.
