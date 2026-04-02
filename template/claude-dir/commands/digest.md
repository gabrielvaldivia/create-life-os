Generate an end-of-day digest and save it to `digests/`.

## Steps

1. **Get today's date.**

2. **Backfill yesterday if needed.** Check yesterday's digest. Look for late-night data that happened AFTER the digest was last written (journal entries, late messages, commits). If found, add them to yesterday's digest before proceeding.

3. **Check for missed days (catchup mode).** Look in `digests/` for the most recent digest file.
   - If the last digest is older than yesterday, generate a digest for EACH missing day, oldest first, before writing today's.
   - Each day gets its own `digests/YYYY-MM-DD.md` file.
   - Open loops carry forward from each day to the next.

4. **Check if today's digest already exists** (`digests/YYYY-MM-DD.md`).
   - **If it exists**: read it carefully. This is an **incremental update**, add new information and correct errors, don't rewrite from scratch.
   - **If it doesn't exist**: write a fresh digest.

5. **Pull available data.** Check each source and use whatever is connected. Run in parallel where possible. If pre-fetched data is provided in the prompt (headless run), use that instead of calling MCP tools.

   - **Google Calendar**: Fetch today's events from all configured calendars. Merge and deduplicate.
   - **Gmail (received)**: Search `is:anywhere after:YYYY/M/D -label:spam -label:promotions`. Use `is:anywhere` not `in:inbox`, many people archive emails quickly. Read full threads for context.
   - **Gmail (sent)**: Search `in:sent after:YYYY/M/D`. Critical for knowing what's already been responded to. Read content, not just subject lines.
   - **Beeper**: Search chats for today's messages. Paginate through all results, don't stop at the first page. Read message content for context.
   - **Reminders**: Read `reminders/reminders.md`. Only note unchecked items.
   - **Journal**: Read any entries from `journal/entries/` for today (matching `YYYY-MM-DD*`).
   - **Git**: Check commits for the day: `git log --since="midnight" --oneline`. Summarize what was shipped.

   If a source isn't connected or returns an error, skip it and note it was unavailable. Don't fail the digest because one source is missing.

6. **Cross-reference before writing.** This is the most important step:
   - For every inbound email, check if a reply was sent. If replied, note it as handled.
   - **If an email is archived (no INBOX label), treat it as resolved.** Do not flag as an open loop.
   - For every inbound message, check if a reply was sent in the same chat.
   - For every potential open loop, verify it's genuinely unresolved before including it.
   - Never assume something is open just because an inbound message exists.

7. **Verify open loops.** This is a hard gate. You CANNOT write the Open Loops section without completing every sub-step below.

   **7a — List yesterday's open loops.** Read yesterday's digest. Copy every open loop into a numbered list. You must account for ALL of them, every single one gets either "CARRY FORWARD" or "RESOLVED (evidence: ...)". No silent drops. **If an open loop has been checked off (`- [x]`), it is resolved.**

   **7b — List new candidates.** From today's data, identify any NEW potential open loops (unanswered messages, promises made, decisions pending). Add them to the list.

   **7c — Verify EVERY candidate.** For each item, check available sources in order. Record what you checked and what you found:
   - Did you send a reply? (Gmail sent, Beeper outbound)
   - Is the email archived? (no INBOX label = resolved)
   - Did you already follow up in another channel?

   Rules:
   - **If ANY source shows you responded, it is RESOLVED. Do not include.**
   - **If an email is archived, it is RESOLVED. Do not include.**
   - **If you already did your part (sent a message, replied, followed up), it is NOT your open loop.** The ball is in the other person's court. Don't include "waiting on reply" items where you have nothing left to do.
   - **If no evidence of response in any source, it is OPEN. Include.**

   **7d — Output the verification log.** Show it before writing the digest:

   ```
   ## Open Loop Verification

   Yesterday's loops:
   1. [Topic]: RESOLVED — [specific evidence] / CARRY FORWARD — [what was checked]

   New candidates:
   2. [Topic]: OPEN — [what triggered it, what was checked]
   ```

8. **Write or update the digest:**

   - **If updating**: use targeted edits. Add new items, correct errors, resolve stale open loops. Don't rewrite sections that haven't changed.
   - **If writing fresh**: create the full file using the format below.

```markdown
# Digest, [Month Day, Year]

## Schedule
- [Time]: [Event name], [attendees or brief context]
- [List all calendar events chronologically]

## Conversations
- [Group by topic, project, or person. Combine all sources (email, Beeper, Slack, meetings) for the same topic into one section]
- [Email threads go here, not in a separate Email section]
- [Meeting details go here, not in a separate Meetings section]

### Personal
- [Non-work conversations, friends, family]

## Health
- [Write conversationally. 1-2 sentences. Only include if health data exists.]

## Reminders
- [ ] [Use checkboxes. Only list UNCHECKED reminders, skip completed ones]
- [Omit this section if all reminders are checked or no reminders exist]

## Open Loops
- [ ] [Use checkboxes. Check off (`- [x]`) to mark resolved in future digests]
- [ ] [Only things where YOU have a direct action or someone is waiting on YOU]
- [ ] [If you already did your part, it's not your open loop]

## Journal
- [Include journal entries from `journal/entries/YYYY-MM-DD*`]
- [Preserve the writer's voice, don't editorialize]
- [Omit if no journal entries exist for today]

## Wins
- [Things you did, decided, shipped, or experienced]
- [Milestones, code shipped, tasks completed, good conversations, personal moments]
- [If you weren't the one who did it, it's not your win]
```

9. **Save** the file to `digests/YYYY-MM-DD.md`.

10. **Send a Beeper notification.** If Beeper is connected, search for the "Note to self" chat using `search_chats`, then send a concise summary using `send_message`. Keep it under 500 characters: key wins, open loops count, and a one-line vibe check on the day. Skip this step if Beeper isn't available.

11. **Show the digest** and ask if anything is missing or needs correction. Be direct, highlight open loops and anything that looks like a dropped ball.

## Important

- **Incremental by default.** If a digest already exists, update it, don't rewrite it.
- **Never fabricate anything.** If you can't trace a claim to a specific source, don't include it.
- **Archived email = resolved.** If an email has no INBOX label, treat it as handled.
- **Every entry must have substance.** No one-liners with no detail. State what was discussed, decided, or requested. If you can't extract meaningful content, omit the entry. Never include "no new activity" entries.
- **Read message content, not just metadata.** Subject lines and contact names alone are not enough.
- **Don't infer actions that aren't stated.** Only state what messages explicitly say happened.
- **No em dashes or en dashes.** Use commas, periods, or colons instead.
- **Skip spam and noise.** If a message is clearly spam or an unsolicited DM, don't include it.
- **Sections are optional.** If there's nothing for a section, omit it entirely. Don't write empty sections.
- Be a coach: call out things the user might be avoiding or forgetting, but only verified items.
