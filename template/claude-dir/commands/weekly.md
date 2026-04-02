Sunday evening week-ahead check-in. Highlights what's coming this week so you can walk into Monday prepared.

## Steps

1. **Get today's date** and calculate Monday through Sunday of the upcoming week.

2. **Pull data in parallel:**

   - **Google Calendar**: Fetch the full upcoming week (Mon-Sun) from all configured calendars. Merge and deduplicate.
   - **Recent digests**: Read the last 2-3 digests for open loops carrying forward.
   - **Gmail (received)**: Search `in:inbox after:YYYY/M/D` for the past few days. Read full threads for context.
   - **Gmail (sent)**: Search `in:sent after:YYYY/M/D` for the past few days to know what's already been replied to.
   - **Beeper**: Search recent chats for messages from the past few days. Paginate fully. Look for upcoming plans and social events.
   - **Weather**: Fetch a 7-day forecast from Open-Meteo: `curl -s "https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&daily=temperature_2m_max,temperature_2m_min,weathercode&temperature_unit=fahrenheit&timezone={TZ}&forecast_days=7"`. Summarize Mon-Sun conversationally.

   If a source isn't connected or returns an error, skip it gracefully.

3. **Goal check-in:** Read the current year's goals file. For each goal with monthly targets or weekly actions, check recent digests for evidence of progress. Note which goals got attention and which didn't.

4. **Cross-reference before writing.** For every potential open loop, verify it's genuinely unresolved:
   - Search Gmail sent for a reply
   - Search Beeper for a response
   - **If you find ANY evidence of a response, DO NOT include it as an open loop.**

5. **Write the check-in** using **bold text** for section labels, not headings:

```
**Week of [Month] [Monday date]-[Sunday date]**

[2-3 sentence weather summary for the week.]

**Meetings**
[One conversational paragraph. Highlight NEW non-recurring meetings. Use "tomorrow" instead of "Monday" since this is sent Sunday night.]

**Personal plans**
- [Dinner invites, social events, family plans from messages and calendar]
- [Only include if there are concrete plans]

**Big focus areas**
- What are the main themes/projects for the week?
- What needs to ship or get decided?

**Goal check-in**
- For each goal with current month targets: note progress or flag no activity
- Only include goals that are at risk or got zero attention
- Skip this section if no structured goals exist yet (suggest running /goals)

**Open loops**
- Carried forward from recent digests, verified as unresolved
- Only items where you have a direct action or someone is waiting on you
```

6. **Send a Beeper notification.** If Beeper is connected, search for the "Note to self" chat using `search_chats`, then send the full check-in using `send_message`. Skip this step if Beeper isn't available.

7. **Show the check-in** directly, don't save to a file.

## Important

- **Never fabricate anything.** Every claim must be traceable to a specific source.
- **Always cross-reference.** Check sent emails and messages before marking anything as an open loop.
- **If a data source isn't connected**, skip it and note it was skipped.
- Keep it tight and scannable.
- Deduplicate: don't repeat items across sections.
- This is a high-level view of the week, not a detailed daily breakdown.
