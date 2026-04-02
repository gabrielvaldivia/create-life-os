Set up automation so your skills run on a schedule, even when Claude Code isn't open.

## What it does

Automation uses the Life OS Mac app, a native menu bar companion that:
- Discovers all your skills automatically from `.claude/commands/`
- Lets you schedule any skill to run daily or weekly at a specific time
- Pre-fetches all data (calendar, email, messages, reminders, git, weather) before running each skill headlessly
- Monitors your data source connections

## Steps

1. **Check for the Life OS Mac app.** Ask the user:

   "Do you have the Life OS menu bar app installed? It's a native Mac app that runs your skills on a schedule."

   If they don't have it, say:

   "Download it here: https://github.com/gabrielvaldivia/create-life-os/releases/latest/download/LifeOS-mac.zip

   Unzip it, move it to your Applications folder, and open it. It lives in your menu bar. Then come back here."

   Wait for them to confirm.

2. **Set the repo path.** Tell the user:

   "Open the Life OS app from your menu bar, go to Settings, and make sure your repo path is set to this folder."

   Confirm the path matches the current working directory.

3. **Check if Google API scripts exist.** Look for `scripts/google-token.sh`. If it doesn't exist, set up Google API access for headless runs:

   a. Ask the user: "To run skills automatically, I need direct Google API access for calendar and email. Go to console.cloud.google.com, create an OAuth 2.0 Desktop client, and give me the client ID and client secret."

   b. Once they provide credentials, store them in Keychain:
   ```bash
   security add-generic-password -U -s "lifeos-google-client-id" -a "lifeos" -w "CLIENT_ID"
   security add-generic-password -U -s "lifeos-google-client-secret" -a "lifeos" -w "CLIENT_SECRET"
   ```

   c. Create `scripts/google-auth-setup.sh`, `scripts/google-token.sh`, `scripts/read-calendar-api.sh`, and `scripts/read-email-api.sh`. These scripts use curl + Google APIs directly.

   d. Run the auth setup to get the refresh token.

4. **Recommend a schedule.** Tell the user:

   "Open the Life OS app and schedule the skills you want to automate. Here's a good starting point:

   - `/morning` — daily at 7:00 AM
   - `/digest` — daily at 8:00 PM

   You can schedule any skill. The app shows all your skills from `.claude/commands/`. Just click the + button, pick a skill, set a time, and you're done."

5. **Test it.** Have the user trigger one skill manually from the app to confirm it works.

6. **Confirm to the user:**

   "Automation is set up. Your skills will run on schedule through the Life OS app. You can change times, add new skills, or pause automations anytime from the menu bar.

   A few things to know:
   - The app needs to be running for scheduled skills to fire
   - Each skill gets all your data pre-fetched automatically (calendar, email, messages, etc.)
   - Logs are in `~/.local/log/` if you ever need to debug a run"

## Key design principles

- **Pre-fetch everything.** `claude -p` cannot reliably use MCP tools in headless mode. The headless runner collects all data in bash first and passes it in the prompt.
- **Fail gracefully.** If one data source fails, the skill continues with what it has. A digest with partial data is better than no digest.
- **Any skill can be automated.** The headless runner is universal. Schedule `/digest`, `/morning`, `/weekly`, `/goals-review`, or any custom skill you create.

## Important

- The Life OS app must be running for scheduled skills to fire. Add it to your Login Items (System Settings > General > Login Items) so it starts on boot.
- Google OAuth tokens on Workspace accounts don't expire. Consumer accounts in "Testing" mode expire after 7 days — set to "Production" to avoid this.
- If the Google token expires, the pre-fetch scripts will print clear error messages. Re-run `scripts/google-auth-setup.sh` to fix.
