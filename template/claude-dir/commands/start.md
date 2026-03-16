Start your daily automation loops. Run this once when you open Claude Code — it sets up recurring tasks for morning briefings, digests, and syncing.

## What it does

When you run `/start`, set up these three loops using the `/loop` built-in skill:

1. `/loop 8h /morning` — runs your morning briefing every 8 hours
2. `/loop 8h /digest` — runs your end-of-day digest every 8 hours
3. `/loop 4h /sync` — syncs your data sources every 4 hours

## Steps

1. Tell the user:

   "Starting your Life OS loops. These will run in the background while this session is open."

2. Run each loop by invoking the `/loop` skill three times:
   - `/loop 8h /morning`
   - `/loop 8h /digest`
   - `/loop 4h /sync`

3. Confirm:

   "Your Life OS is running:
   - **/morning** — every 8 hours
   - **/digest** — every 8 hours
   - **/sync** — every 4 hours

   These run as long as this Claude Code session is open. Next time you open Claude Code, just run `/start` again."

## Important

- These loops only run while the Claude Code session is active. When you close Claude Code, they stop.
- Running `/start` again is safe — it won't create duplicate loops.
- The user can also run `/morning`, `/digest`, or `/sync` manually at any time.
