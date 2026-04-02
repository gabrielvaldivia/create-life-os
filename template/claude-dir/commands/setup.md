First-time setup. Walk through configuring your Life OS step by step.

## Steps

1. **Welcome.** Say this:

   "Welcome to Life OS. I'm going to help you set up your second brain. This is a system for keeping track of your life — journaling, daily reviews, goals, the people you care about. Everything lives in plain markdown files in this repo, and you interact with it through me.

   We'll go through this together, one step at a time. It should take about 10 minutes. Ready?"

   Wait for their response before continuing.

2. **Identity — who are you?** Ask:

   "Let's start with the basics. What's your name, where do you live, and what do you do? One or two sentences is plenty."

   Wait for their response. Store their answer for use in CLAUDE.md.

3. **Family and key people.** Ask:

   "Who are the most important people in your life? Partner, kids, close family, whoever comes to mind first. Just names and how they relate to you."

   Wait for their response. If they don't want to share, that's fine — skip it.

4. **Life pillars.** Use the AskUserQuestion tool with multiSelect: true:

   Question: "What are your life pillars — the big areas you want to invest in? Pick the ones that resonate, or write in your own."
   Header: "Pillars"
   Options:
   - "Family" — "Partner, kids, parents — being present for the people closest to you"
   - "Career" — "Your work, professional growth, building something meaningful"
   - "Health" — "Physical fitness, mental health, energy, longevity"
   - "Friendships" — "Maintaining and deepening your social connections"

   The user can also type in custom pillars via the "Other" option. After they respond, confirm their selections and ask if they want to add any others.

5. **Communication style.** Use the AskUserQuestion tool:

   Question: "How do you want me to talk to you?"
   Header: "Style"
   Options:
   - "Coach" — "Push back, challenge me, call me out when I'm avoiding things"
   - "Calm assistant" — "Supportive, gentle, no pressure"
   - "Direct and brief" — "No fluff, just the facts, keep it short"
   - "Casual and warm" — "Like talking to a smart friend"

   The user can also type a custom preference via "Other".

6. **Goals (optional).** Ask:

   "Do you have any goals you're actively working toward right now? Could be anything — career milestones, fitness targets, creative projects, relationship goals. If nothing comes to mind, we can skip this and add goals later."

   Wait for their response.

7. **Create identity/profile.md.** This is the single source of truth for who the user is. Write it using everything they shared:

   ```markdown
   # [Name] — Identity Profile

   *Last updated: [today's date]*

   ## Who They Are
   [Name, location, what they do. Use their words.]

   ## Family & Key People
   [Everyone they mentioned, with relationships. Link to people files: [[people/firstname-lastname|Name]]]

   ## Life Pillars
   [Numbered list of their pillars with brief descriptions]

   ## Goals
   [What they're working toward, if they shared any. Otherwise omit this section.]
   ```

   Keep it simple. This file grows over time as the system learns more about them.

8. **Update CLAUDE.md.** Update `CLAUDE.md` to reference the profile instead of containing the info directly. Fill in:
   - The "About You" section should say: `See identity/profile.md for who you are and what matters to you.`
   - Add a short one-liner with their name and what they do (for quick context)
   - Family & Key People section with names only (details live in profile.md and people/ files)
   - Life Pillars section with their pillars (numbered list, brief)
   - Current Goals section (brief, if they shared any)
   - How to Talk to Me section based on their communication style choice. Write it as bullet points in their voice, e.g.:
     - Coach → "Be direct. Push back. Call me out when I'm avoiding things."
     - Calm assistant → "Be supportive and patient. Guide, don't push."
     - Direct and brief → "Keep it short. No fluff. Just what I need to know."
     - Casual and warm → "Talk to me like a friend. Be real but not cold."
     - Custom → use their words directly

   Preserve the Rules, File Structure, and Workflows sections as-is.

8. **Create folder structure.** Verify these directories exist (create any that are missing):
   - `journal/entries/`
   - `digests/`
   - `people/`
   - `identity/`
   - `goals/`
   - `work/`
   - `health/`
   - `reminders/`

9. **Create people files.** For each person they mentioned in step 3, create a simple file in `people/`:

   Filename: `firstname-lastname.md` (lowercase, hyphens)

   ```markdown
   # [Full Name]

   **Relationship:** [how they described this person]
   ```

   Use their words, not formal language. If they said "my wife Sarah" write "Wife", not "Spouse".

10. **Connect data sources.** Use the AskUserQuestion tool with multiSelect: true:

    Question: "Which data sources do you want to connect? You can add more later."
    Header: "Data sources"
    Options:
    - "Gmail & Google Calendar" — "Pull in your email and schedule for morning briefings and digests"
    - "iMessage" — "Read your text messages via Beeper"
    - "WhatsApp" — "Read your WhatsApp conversations via Beeper"
    - "Slack" — "Read your Slack messages via Beeper"

    The user can also skip via "Other" (e.g., "None for now").

11. **Set up selected data sources.**

    **If they selected Gmail & Google Calendar:**
    Say: "Let's connect Google. Go to Claude Code Settings (the gear icon or Cmd+,) → Connections → click 'Connect' next to Google. Sign in and grant access. Let me know once that's done."

    Wait for their response. If they connected it, test by fetching today's calendar events. Confirm: "Connected! I can see your calendar."

    **If they selected any Beeper sources (iMessage, WhatsApp, or Slack):**
    Say: "To pull in your messages, we'll use Beeper — it's an app that bridges all your messaging into one place. Here's what to do:

    1. Download Beeper at beeper.com and create an account
    2. In the Beeper app, connect [list only the ones they selected — iMessage, WhatsApp, Slack, etc.]
    3. Once your accounts are syncing in Beeper, come back and let me know

    This takes a few minutes. I'll wait."

    When they confirm, create or update `.claude/settings.local.json` to enable the Beeper MCP:

    ```json
    {
      "enabledMcpjsonServers": ["beeper"]
    }
    ```

    Test by listing recent chats. Confirm: "Connected! I can see your messages."

    **If they selected nothing:**
    Say: "No problem. Your journal and goals work without any connections. Morning briefings and digests will use whatever data is available — even just weather and your git activity is useful. You can connect sources anytime."

12. **First journal entry.** Say:

    "Your Life OS is set up. Let's break it in.

    Tell me something — anything. What's on your mind today? A thought, a feeling, what you had for lunch, a decision you're wrestling with. This is your journal. There are no rules."

    Wait for their response. Save it as a journal entry: `journal/entries/YYYY-MM-DD.md` with a timestamp in 12-hour format.

13. **Wrap up.** Say:

    "You're all set. Here's what you've got:

    **Your system:**
    - `CLAUDE.md` — your system prompt. I'll refer to this every time we talk. Update it anytime.
    - Your first journal entry in `journal/entries/`

    **Your daily rhythm:**
    - `/morning` — run this when you start your day. Schedule, weather, what needs your attention.
    - `/digest` — run this before you wrap up. Captures what happened, what shipped, what's still open.
    - `/journal` — jot something down anytime.
    - `/sync` — pull from all your connected sources and update your people files.

    **Automation:**
    - Download the [Life OS Mac app](https://github.com/gabrielvaldivia/create-life-os/releases/latest/download/LifeOS-mac.zip) to run your skills on a schedule from the menu bar. Then run `/automate` to set up Google API access for headless runs.

    **When you're ready:**
    - `/goals` — set structured goals tied to your life pillars.

    Start with `/morning` tomorrow. When you want things to run automatically, grab the Mac app and run `/automate`. The system grows with you — don't try to set up everything at once."

14. **Commit.** Stage all new and modified files. Commit with the message: "Initial Life OS setup". Do not push unless they ask.

## Important

- Go one step at a time. Never dump multiple questions in a single message.
- Wait for their response at every step before moving on.
- Use their words, not corporate language. If they say "my wife Sarah" don't write "Spouse: Sarah."
- If they seem unsure about pillars or goals, reassure them these can change anytime. Don't pressure.
- Keep the tone warm and direct. This should feel like a conversation, not onboarding.
- If they want to skip a step, let them. Nothing is required except the name.
- Don't explain markdown syntax or git concepts unless they ask.
- Use the AskUserQuestion tool for steps 4, 5, and 10. Use regular conversation for everything else.
