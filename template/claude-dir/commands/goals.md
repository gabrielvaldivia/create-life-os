Interactive goal-setting tied to your life pillars. Produces a structured goals file with measurable goals, quarterly milestones, monthly targets, and weekly actions.

## Steps

1. **Read existing context.** Read life pillars from `CLAUDE.md`. Check if a goals file exists for the current year (`goals/YYYY.md`).

2. **Determine mode:**
   - If a goals file already has structured goals (quarterly milestones, success criteria), ask: "Want to do a full reset or just update specific pillars?" If updating, ask which pillars to revisit. Preserve everything else unchanged.
   - If no goals file exists or it's just simple checkboxes, treat as first run.

3. **For each pillar being worked on**, walk through this flow conversationally. Don't dump all questions at once. Go one pillar at a time, one step at a time. Wait for the user's response before moving to the next step.

   **Step A: Reflect**
   "How are you feeling about [pillar] right now? What's working, what's not?"

   **Step B: Focus areas**
   Based on their response and what's already in the goals file, suggest 2-4 concrete focus areas as options. Include a write-in option. Ask them to pick 1-3.

   Example for Career:
   - [ ] Get promoted by Q3
   - [ ] Build a side project and launch it
   - [ ] Develop a new technical skill
   - [ ] Something else: ___

   **Step C: Success criteria**
   For each chosen focus area: "How will you know you've nailed this by December? What's the concrete outcome?"

   **Step D: Quarterly milestones**
   "Let's break this down by quarter. What needs to happen in Q1 to stay on track? Q2?" Walk through all four quarters.

   **Step E: This month's targets**
   "What are the 2-3 things you can do THIS month to hit your Q[current] milestone?"

   **Step F: This week's first step**
   "What's one thing you can do THIS WEEK to get moving on this?"

4. **After all selected pillars are done**, compile everything into `goals/YYYY.md` using this format:

```markdown
# [Year] Goals

*Last updated: YYYY-MM-DD*
*Next review: YYYY-MM-DD (end of current quarter)*

## [Pillar Name]
### [Goal statement — specific and measurable]
- **Why:** [Motivation]
- **Success:** [Concrete outcome by December]
- **Q1:** [Milestone]
- **Q2:** [Milestone]
- **Q3:** [Milestone]
- **Q4:** [Milestone]

#### [Current month] targets
- [ ] [Target 1]
- [ ] [Target 2]

#### This week ([date range])
- [ ] [Action item]

[Repeat for each goal under this pillar]

[Repeat for each pillar]
```

5. **Save the file** to `goals/YYYY.md`. Show the user the final output.

## Important

- **Go deep, not wide.** It's better to have 2 well-defined goals per pillar than 5 vague ones.
- **Push for specificity.** "Get healthier" is not a goal. "Run 3x/week and hit 165 lbs by September" is.
- **Be a coach.** Challenge weak goals. Ask "is that ambitious enough?" or "is that realistic given your schedule?"
- **Preserve existing work.** In incremental mode, don't touch pillars the user didn't select for revision.
- **Use the user's own words** where possible. Don't over-formalize their language.
- **Monthly targets and weekly actions** should only be filled in for the current month/week. Future months get filled in during reviews.
