Morning briefing. Review yesterday, see today's schedule, surface what needs attention.

## Steps

1. **Get today's date** and determine if it's a weekday or weekend.

2. **Check for yesterday's digest.** If `digests/YYYY-MM-DD.md` exists for yesterday, read it. Note any open loops.

   **CRITICAL CHECK**: If yesterday's digest does NOT exist, say this FIRST: "**Yesterday's digest is missing. Running /digest for yesterday now.**" Then run the digest for yesterday before proceeding.

3. **Pull available data.** Check each source and use whatever is available. If pre-fetched data is provided in the prompt (headless run), use that instead of calling MCP tools.

   - **Weather**: Detect timezone via `readlink /etc/localtime | sed 's|.*/zoneinfo/||'` (fallback: "America/New_York"). Fetch: `curl -s "https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&daily=temperature_2m_max,temperature_2m_min,weathercode&hourly=temperature_2m,weathercode&temperature_unit=fahrenheit&timezone={TZ}&forecast_days=1"`. Weather codes: 0=clear, 1-3=partly cloudy/overcast, 45-48=fog, 51-55=drizzle, 61-65=rain, 71-75=snow, 80-82=showers, 95=thunderstorm.
   - **Google Calendar**: Fetch today's events from all configured calendars. Merge and deduplicate.
   - **Gmail (received)**: Search `is:anywhere after:YYYY/M/D -label:spam -label:promotions`. Read full threads.
   - **Gmail (sent)**: Search `in:sent after:YYYY/M/D`. Critical for knowing what's already been replied to.
   - **Beeper**: Search recent chats for messages from the last 24 hours. Paginate fully.
   - **Reminders**: Read `reminders/reminders.md`. Only note unchecked items.
   - **Yesterday's digest**: Read open loops section.
   - **Git**: Run `git log --since="yesterday" --oneline`.

   If a source isn't connected or returns an error, skip it gracefully.

4. **Cross-reference before writing.**
   - For any inbound email, check if a reply was already sent. Don't mark as "needs a reply" if handled.
   - **If an email is archived (no INBOX label), treat it as resolved.**
   - For any message, check if a reply was sent in the same chat.
   - Never assume something is an open loop just because an inbound message exists.

5. **Verify open loops before including them.** For EVERY item from yesterday's digest:
   - Check sent email, sent messages for a response
   - **If you already did your part, it's not your open loop**
   - Each loop gets "CARRY FORWARD" or "RESOLVED (evidence)". No silent drops.

6. **Write the briefing.** Use **bold text** for section labels, not # headings. No em dashes or en dashes.

### Weekday format:

```
**[Day of week], [Month Day]**
[Conversational weather summary. High/low, conditions, what to wear.]

**Schedule**
- [Time]: [Event], [brief context if notable]
- Skip recurring meetings unless something unusual is happening
- Highlight what stands out: new people, first meetings, deadlines

**Reminders**
- [Unchecked reminders only]
- Omit this section if there are no unchecked reminders

**On your plate**
1. [Open loops where you have a direct action]
2. [Anything from email or messages that needs YOUR response]
- Use a numbered list so items feel prioritized
- If you already did your part, it's not on your plate
```

### Weekend format:

```
**[Day of week], [Month Day]**
[Conversational weather summary. High/low, conditions.]

**This weekend**
- [Only personal and family events]
- [Skip all work items]
```

7. **Omit empty sections.** If there's nothing for a section, leave it out entirely.

8. **Send a Beeper notification.** If Beeper is connected, search for the "Note to self" chat using `search_chats`, then send the full briefing using `send_message`. Skip this step if Beeper isn't available.

9. **Show the briefing** directly. Don't save to a file.

10. **Ask**: "Anything you want to adjust for today?"

## Important

- **Never fabricate anything.** Every claim must be traceable to a specific source.
- **Always cross-reference.** Check sent emails and messages before saying something needs a reply.
- **Archived email = resolved.** No INBOX label means it's been handled.
- **If you already did your part, it's not your open loop.**
- **If a data source isn't connected**, skip it gracefully.
- **No em dashes or en dashes.** Use commas, periods, or colons.
- **Weekends are personal.** No work items, no professional open loops.
- **Deduplicate.** Don't repeat items across sections.
- Keep it tight and scannable.
