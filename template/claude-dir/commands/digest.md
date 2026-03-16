Generate an end-of-day digest and save it to `digests/`.

## Steps

1. **Get today's date.**

2. **Check for missed days (catchup mode).** Look in `digests/` for the most recent digest file.
   - If the last digest is older than yesterday, you need to generate a digest for EACH missing day, oldest first, before writing today's.
   - Each day gets its own `digests/YYYY-MM-DD.md` file.
   - Open loops carry forward from each day to the next.
   - For catchup days, scope each data source to that specific day (e.g., Gmail `after:YYYY/M/D before:YYYY/M/D`, calendar events for that date, git log `--since="YYYY-MM-DD" --until="YYYY-MM-DD"`, Beeper messages in that date range).
   - If catching up, briefly tell the user: "Looks like you missed [N] days. Let me catch up." Then generate each day's digest in sequence.

3. **Check if today's digest already exists** (`digests/YYYY-MM-DD.md`).
   - **If it exists**: read it carefully. This is an **incremental update** — add new information and correct errors, don't rewrite from scratch.
   - **If it doesn't exist**: write a fresh digest.

4. **Pull available data.** Check each source and use whatever is connected. Run these in parallel where possible:

   - **Google Calendar**: Fetch today's events from all configured calendars. Merge and deduplicate.
   - **Gmail (received)**: Search `is:anywhere after:YYYY/M/D before:YYYY/M/D+1 -label:spam -label:promotions`. Use `is:anywhere` not `in:inbox` — many people archive emails quickly. Read full threads for context.
   - **Gmail (sent)**: Search `in:sent after:YYYY/M/D before:YYYY/M/D+1`. This is critical for knowing what's already been responded to. Read content, not just subject lines.
   - **Beeper**: Search chats for today's messages. Paginate through all results with `direction='before'` — don't stop at the first page. Read message content for context.
   - **Reminders**: Read `reminders/reminders.md`. Note which items are checked (`- [x]`) and which are unchecked (`- [ ]`). If the file doesn't exist or is empty, skip.
   - **Git**: Check commits for the day: `git log --since="YYYY-MM-DDT00:00" --until="YYYY-MM-DDT23:59" --oneline`. Summarize what was shipped or worked on.

   If a source isn't connected or returns an error, skip it and note it was unavailable. Don't fail the digest because one source is missing.

5. **Cross-reference before writing.** This is the most important step:
   - For every inbound email, check if a reply was sent. If replied, note it as handled.
   - For every inbound Beeper message, check if a reply was sent in the same chat.
   - For every potential open loop, verify it's genuinely unresolved before including it.
   - Never assume something is open just because an inbound message exists.

6. **Check previous open loops.** If a previous digest exists (yesterday's or the last catchup day's), read its Open Loops section. For each item, check if it was resolved today. Carry forward anything still open. Drop anything that's been handled.

7. **Write or update the digest:**

   - **If updating**: use targeted edits. Add new items, correct errors, resolve stale open loops. Don't rewrite sections that haven't changed.
   - **If writing fresh**: create the full file using the format below.

```markdown
# Digest — [Month Day, Year]

## Schedule
- [Time] [Event name] with [attendees]
  - Key points, decisions, or action items (if any)

## Email
- [Thread subject] — [summary of what happened, including your reply if you sent one]

## Conversations
- [Summary of notable conversations from any source — Beeper, Slack, WhatsApp, iMessage]

## Shipped
- [What got committed, deployed, completed, or meaningfully advanced today]

## Reminders
- [List reminders from reminders/reminders.md with their checkbox status]
- [Omit this section if no reminders exist]

## Open Loops
- Things that need follow-up tomorrow
- Promises you made to people
- Decisions pending that involve you
- ONLY include items verified as unresolved

## Wins
- Anything worth celebrating today, even small things
```

8. **Save** the file to `digests/YYYY-MM-DD.md`.

9. **Show the digest** and ask if anything is missing or needs correction. Be direct — highlight open loops and anything that looks like a dropped ball.

## Important

- **Catchup first.** Always check for missed days before writing today's digest. Don't silently skip days.
- **Incremental by default.** If a digest already exists for a day, update it — don't rewrite it.
- **Never fabricate anything.** If you can't trace a claim to a specific source, don't include it. If a source returns nothing, skip that section.
- **Always cross-reference.** The biggest mistake is saying something "needs a reply" when it's already been handled.
- **If a data source isn't connected**, skip it gracefully. A digest with just git commits and open loops is still valuable.
- **Every entry must have substance.** Never include a one-liner with no detail (e.g., "Email from Sarah" is useless). State what was discussed, decided, or requested.
- **Sections are optional.** If there's nothing for a section, omit it entirely. Don't write "No email today." Just leave the section out.
- Keep summaries tight — bullet points, not paragraphs.
- Be a coach: call out things the user might be avoiding or forgetting — but only verified items.
