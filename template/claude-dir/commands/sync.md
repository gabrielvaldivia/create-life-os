Sync all connected data sources into your Life OS files and commit changes.

## Steps

1. **Get today's date and read CLAUDE.md** for context (who the user is, their people, pillars).

2. **Take a snapshot.** Run `git diff --stat` to see the current state before syncing. This lets us show what changed at the end.

3. **Check which data sources are available.** Try each one — if it works, use it. If it errors or isn't connected, skip it and note it was unavailable. Check these in parallel where possible:

   - **Google Calendar**: Fetch today's events from all calendars. If this works, Calendar is connected.
   - **Gmail**: Search for recent emails (`is:anywhere after:YYYY/M/D -label:spam -label:promotions`). Also check sent (`in:sent after:YYYY/M/D`). If this works, Gmail is connected.
   - **Beeper**: Search recent chats. Paginate through results with `direction='before'` — don't stop at the first page. If this works, Beeper is connected.
   - **Git**: Run `git log --since="midnight" --oneline` across the repo. This always works.

4. **Update people files.** For each person mentioned in today's data (emails, messages, calendar events) who already has a file in `people/`:
   - Update their "Last Contact" date
   - Add any notable context from today's interactions (what was discussed, decisions made)
   - Don't rewrite existing content — append new information

   For people who appear repeatedly but don't have a file yet, create one:
   ```markdown
   # [Full Name]

   **Relationship:** [inferred from context — colleague, friend, client, etc.]

   ## Last Contact
   [Today's date] — [brief summary of interaction]
   ```

   Use the format `firstname-lastname.md` for filenames. Lowercase, hyphens.

5. **Update today's digest if it exists.** If `digests/YYYY-MM-DD.md` already exists, update it with any new information from the sync. If it doesn't exist, skip this — the user can run `/digest` later.

6. **Show what changed.** Run `git diff --stat` again and compare with the snapshot from step 2. Show a clear summary:

   ```
   **Sync complete**

   Sources checked:
   - Google Calendar: ✓ (N events)
   - Gmail: ✓ (N threads)
   - Beeper: ✓ (N conversations)
   - Git: ✓ (N commits today)

   Files updated:
   - people/jane-doe.md — updated last contact
   - people/john-smith.md — new file created
   - digests/2025-01-15.md — added email summary
   ```

   If any sources were unavailable, note them:
   ```
   - Gmail: not connected (skip)
   ```

7. **Commit changes.** Stage all modified files in `people/` and `digests/`. Commit with the message: "Sync [date]". Do not push unless the user asks.

## Important

- **Never fabricate anything.** Only update files based on real data from connected sources. If a source returns nothing, say so — don't make up interactions.
- **Don't overwrite existing content.** Append new information, update dates, add context. Never delete or rewrite what's already in a file.
- **People files are append-friendly.** Add new interactions to the History or Last Contact section. Don't reorganize existing content.
- **Skip gracefully.** If a source isn't connected, note it and move on. A sync with just git activity is still useful.
- **Be concise in the summary.** The user wants to know what changed, not a wall of text.
- **Don't create people files for everyone.** Only create new files for people who appear in multiple interactions or seem significant. One-off email senders don't need a file.
