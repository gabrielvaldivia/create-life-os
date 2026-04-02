Update your identity profile with new signals from recent activity.

## Steps

1. **Read current profile** — read `identity/profile.md`. Note the `Last updated` date.

2. **Check what's new since last update.** Glob each directory and compare filenames/dates against the `Last updated` date in the profile. Only read files created after that date:
   - New journal entries: `journal/entries/*.md`
   - New digests: `digests/YYYY-MM-DD.md` (compare date in filename)
   - If no files are newer than the last update, skip to step 4.

3. **If there are new local files**, read them and extract signals:
   - New beliefs, opinions, or frameworks expressed
   - Shifts in interests or taste
   - New recurring themes or concerns
   - Changes in tone or voice
   - New relationships or relationship dynamics
   - Wins, frustrations, or growth moments

4. **Check communications** (only if running as a standalone sync, skip if called from another sync):
   - **Calculate the time window**: compute hours since the `Last updated` date in the profile. Use this as the lookback window (minimum 48 hours).
   - **Gmail sent**: Search `in:sent after:YYYY/M/D` (since last update). Read sent email content for tone, voice, how you frame things, beliefs expressed.
   - **Beeper**: Search sent messages since last update. Paginate through all pages. Look for communication patterns, tone shifts across different audiences, beliefs expressed in conversation. Skip gracefully if unavailable.

5. **Verify sources checked** — before updating the profile, confirm each source was checked:
   - Journal entries: checked / nothing new / skipped (reason)
   - Digests: checked / nothing new / skipped (reason)
   - Gmail sent (standalone only): checked / nothing new / skipped (reason)
   - Beeper (standalone only): checked / nothing new / skipped (reason)

   **If any source was not checked, go back and check it before proceeding.**

6. **Update the profile.** Don't rewrite from scratch. Only:
   - Add new data points to existing sections
   - Update sections where signals have shifted
   - Add new sections if a genuinely new theme emerges
   - Update the `Last updated` date
   - The profile is the single source of truth for your identity. Everything goes here: beliefs, decisions, routines, preferences, self-knowledge, relationship dynamics.

## Important
- **Don't rewrite the whole profile on every sync.** Incremental updates only. The profile should get richer and more nuanced over time, not longer and more repetitive.
- **Don't dilute strong existing observations with noise.** Only update when there's a genuine signal — a new belief expressed, a shift in interests, a change in voice or tone.
- **If nothing meaningful has changed**, just update the date and note "No significant changes." Don't force updates.
- **Prioritize quality of insight over quantity of data points.**
- **If Beeper MCP is unavailable**, skip it and note it was skipped. Don't fail the whole sync.
- **Never fabricate observations.** If you can't trace a signal to a specific source, don't include it.
