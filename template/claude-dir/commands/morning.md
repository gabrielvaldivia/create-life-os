Morning briefing. Review yesterday, see today's schedule, surface what needs attention.

## Steps

1. **Get today's date** and determine if it's a weekday or weekend.

2. **Check for yesterday's digest.** If `digests/YYYY-MM-DD.md` exists for yesterday, read it. Note any open loops that might carry forward.

3. **Pull available data.** Check each source and use whatever is available. Run these in parallel where possible:

   - **Google Calendar**: Fetch today's events. If the user has multiple calendars configured in CLAUDE.md, check all of them. Merge and deduplicate by time.
   - **Gmail**: Search for emails received in the last 24 hours (`is:anywhere after:YYYY/M/D -label:spam -label:promotions`). Also check sent mail (`in:sent after:YYYY/M/D`) to know what's already been replied to.
   - **Beeper**: Search recent chats for messages from the last 24 hours. Paginate through results with `direction='before'` — don't stop at the first page. Summarize notable conversations.
   - **Yesterday's digest**: Read `digests/YYYY-MM-DD.md` for yesterday. Note open loops.
   - **Weather**: Fetch the forecast using the Open-Meteo API. First detect the system timezone by running `readlink /etc/localtime | sed 's|.*/zoneinfo/||'` (falls back to "America/New_York" if detection fails). Then get today's forecast using the location from CLAUDE.md (default to New York if not set): `curl -s "https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&daily=temperature_2m_max,temperature_2m_min,weathercode&hourly=temperature_2m,weathercode&temperature_unit=fahrenheit&timezone={DETECTED_TZ}&forecast_days=1"`. Weather codes: 0=clear, 1-3=partly cloudy/overcast, 45-48=fog, 51-55=drizzle, 61-65=rain, 71-75=snow, 80-82=showers, 95=thunderstorm.

   If a source isn't connected or returns an error, skip it gracefully. Don't fail the whole briefing because one source is missing.

4. **Cross-reference before writing.** This is critical:
   - For any inbound email, check if a reply was already sent. Don't mark something as "needs a reply" if it's already been handled.
   - For any Beeper message, check if a reply was sent in the same chat.
   - Never assume something is an open loop just because an inbound message exists.

5. **Write the briefing** using this format:

### Weekday format:

```
**[Day of week], [Month Day]**
[Conversational weather summary. High/low, conditions, what to wear.]

**Schedule**
- [Time]: [Event] — [brief context if notable]
- Skip recurring meetings unless something unusual is happening
- Highlight what stands out: new people, first meetings, deadlines

**On your plate**
1. [Open loops from yesterday's digest where you have a direct action]
2. [Anything from email or messages that needs a response]
- Use a numbered list so items feel prioritized

**Heads up**
- [Anything notable from messages or email worth knowing about, even if no action needed]
```

### Weekend format:

```
**[Day of week], [Month Day]**
[Conversational weather summary. High/low, conditions.]

**Schedule**
- [Only personal and family events]

**This weekend**
- [Personal plans, social events, family activities]
- [Skip all work items]
```

6. **Omit empty sections.** If there's nothing for Schedule, On your plate, or Heads up — leave the section out entirely. Don't write "Nothing on your plate today."

7. **Show the briefing** directly. Don't save to a file.

8. **Ask**: "Anything you want to adjust for today?"

## Important

- **Never fabricate anything.** Every claim must be traceable to a specific source (email, calendar, message, yesterday's digest). If you can't find it, don't include it.
- **Always cross-reference.** Check sent emails and sent messages before saying something needs a reply.
- **If a data source isn't connected**, skip it gracefully. A briefing with just weather and yesterday's digest is still useful.
- **Weekends are personal.** No work items, no professional open loops.
- **Deduplicate.** Don't repeat items across sections.
- Keep it tight and scannable.
- Be a coach: call out things they might be avoiding or forgetting — but only if they're real, verified items.
