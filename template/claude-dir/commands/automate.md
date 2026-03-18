Set up headless automation so your morning briefings and nightly digests run automatically, even when Claude Code isn't open.

## What it does

Creates macOS LaunchAgents that run at fixed times every day:
- **Morning briefing** at 7:00 AM
- **Nightly digest + sync** at 8:00 PM

Each automation pre-fetches all data (calendar, email, messages, reminders, git) in bash, then passes it to `claude -p` so it works without MCP tools.

## Prerequisites

- Google Calendar and Gmail API access (the script will help you set this up)
- Claude CLI installed (`claude` command available)
- macOS (LaunchAgents are macOS-specific)

## Steps

1. **Check if Google API scripts exist.** Look for `scripts/google-auth-setup.sh`. If it doesn't exist, create the OAuth setup:

   a. Ask the user: "To automate calendar and email, I need to set up direct Google API access. Go to console.cloud.google.com, create an OAuth 2.0 Desktop client, and give me the client ID and client secret."

   b. Once they provide credentials, store them in Keychain:
   ```bash
   security add-generic-password -U -s "gabos-google-client-id" -a "gabos" -w "CLIENT_ID"
   security add-generic-password -U -s "gabos-google-client-secret" -a "gabos" -w "CLIENT_SECRET"
   ```

   c. Create `scripts/google-auth-setup.sh`, `scripts/google-token.sh`, `scripts/read-calendar-api.sh`, and `scripts/read-email-api.sh`. These scripts use curl + Google APIs directly, no TCC permissions needed.

   d. Run the auth setup to get the refresh token.

2. **Create the morning briefing script** at `scripts/morning-briefing.sh`:
   - Pull latest from git
   - Pre-fetch ALL data in bash: weather, calendar (API), email (API), reminders, tasks, yesterday's digest, git log, health
   - Pass everything to `claude -p` with `/morning` instructions
   - Include a once-per-day lock file to prevent duplicate runs

3. **Create the nightly digest script** at `scripts/nightly-digest.sh`:
   - Pull latest from git
   - Pre-fetch ALL data in bash: calendar (API), email (API), reminders, health, git log, journal entries, yesterday's digest, today's existing digest
   - Pass everything to `claude -p` with `/digest` instructions
   - Run `/sync` after the digest
   - Commit and push changes

4. **Create LaunchAgent plist files** in `~/Library/LaunchAgents/`:

   Morning (`com.life-os.morning-briefing.plist`):
   - Runs at 7:00 AM daily
   - 30-minute timeout (kills if hung, so next day's run isn't blocked)
   - Logs to `~/.local/log/`

   Nightly (`com.life-os.nightly-digest.plist`):
   - Runs at 8:00 PM daily
   - 30-minute timeout
   - Logs to `~/.local/log/`

5. **Load the LaunchAgents:**
   ```bash
   launchctl load ~/Library/LaunchAgents/com.life-os.morning-briefing.plist
   launchctl load ~/Library/LaunchAgents/com.life-os.nightly-digest.plist
   ```

6. **Test both scripts** by running them manually and confirming they produce output.

7. **Confirm to the user:**
   "Automation is set up:
   - Morning briefing runs at 7:00 AM
   - Nightly digest + sync runs at 8:00 PM
   - Both have 30-minute timeouts so a hung run can't block future runs
   - Logs are in ~/.local/log/

   You can check logs anytime: `tail -50 ~/.local/log/gabos-morning.log`"

## Key design principles

- **Pre-fetch everything.** `claude -p` cannot reliably use MCP tools in headless mode. All data must be collected in bash first and passed in the prompt.
- **Timeouts on everything.** Every LaunchAgent gets a 30-minute timeout. Every `claude -p` call inside scripts gets a 5-minute timeout. A hung process must never block future runs.
- **Fail gracefully.** If one data source fails, the script continues with what it has. A digest with partial data is better than no digest.
- **Don't rely on apps being open.** No AppleScript, no Calendar.app, no Mail.app. Direct API calls only.

## Important

- LaunchAgents only run when the user is logged in (not during sleep with lid closed)
- Google OAuth tokens on Workspace accounts don't expire. Consumer accounts in "Testing" mode expire after 7 days, set to "Production" to avoid this
- If the Google token expires, the scripts will print clear error messages suggesting the user re-run `scripts/google-auth-setup.sh`
