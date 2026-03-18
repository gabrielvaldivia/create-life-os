Reflect on a mistake you made. Figure out why it happened and prevent it from happening again.

## Steps

1. **Identify the mistake.** State clearly what went wrong, in one sentence. No hedging.

2. **Trace the root cause.** Ask yourself:
   - Was there a rule I should have followed but didn't?
   - Was the rule missing entirely?
   - Was the rule in the wrong place (e.g., in memory but not in the skill that runs the workflow)?
   - Did I make a bad inference or assumption?

3. **Classify the fix type:**
   - **Skill instruction** — embed the rule in the specific skill's `.md` file. Strongest fix, always loaded during that workflow.
   - **CLAUDE.md rule** — applies broadly across all workflows. Good for cross-cutting rules.
   - **Memory** — situational preferences. Weakest fix, can be overlooked.

4. **Prioritize skill instructions over memory.** If the mistake happened during a skill's execution, the fix MUST go in that skill's file. The hierarchy:
   - **Best**: Rule in the skill instructions (always loaded)
   - **Good**: Rule in CLAUDE.md (always loaded)
   - **Weakest**: Rule in memory (loaded on demand, can be missed)

5. **Implement the fix.** Edit the relevant files. Put the rule in the right step of the workflow, clear and specific enough to follow without interpretation.

6. **Summarize.** Tell the user:
   - What the mistake was
   - Why it happened
   - What you changed and where
   - Why this fix will prevent recurrence

## Important

- Be honest about why the mistake happened.
- One mistake can reveal multiple gaps. Fix all of them.
- A single clear sentence in the right place beats a paragraph in the wrong place.
- If the same type of mistake has happened before, escalate to a stronger fix location.
