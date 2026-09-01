---
name: grill-with-docs
description: The grill-me interview pointed at a repo - stress-test a plan or design, and write the resolved vocabulary (CONTEXT.md glossary) and hard decisions (ADRs) into the repo as they crystallise. Use at the start of a change when the plan is fuzzy, or to build domain docs for a repo that has none.
---

Interview the user relentlessly until you reach a shared understanding, and leave a paper trail in the repo as you go. The interview is the same design-tree procedure as `grill-me`; what this skill adds is that terms and decisions land on disk the moment they resolve, not batched at the end.

## The interview

Map the plan as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: only the questions downstream of it wait; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch visited, nothing left silently assumed. Do not act on the plan until the user confirms you have reached a shared understanding.

## Sharpen the domain language as you interview

- **Challenge against the glossary.** If the user uses a term that conflicts with `CONTEXT.md`, call it out immediately: "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"
- **Sharpen fuzzy language.** When a term is vague or overloaded, propose a precise canonical one: "You're saying 'account': do you mean the Customer or the User?"
- **Stress-test with concrete scenarios.** Invent edge-case scenarios that force the user to be precise about the boundaries between concepts.
- **Cross-reference with code.** When the user states how something works, check whether the code agrees; surface contradictions.

## Write CONTEXT.md inline

When a term resolves, update `CONTEXT.md` **right there**, not at the end of the session. Create it lazily at the repo root when the first term resolves. It is a glossary and nothing else: no implementation details, no spec, no scratch notes.

```md
# {Context Name}

{One or two sentences on what this context is and why it exists.}

## Language

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request
```

Rules: be opinionated (pick one word, list rivals under `_Avoid_`); definitions are one or two sentences defining what it IS; only project-specific terms, never general programming concepts.

If a `CONTEXT-MAP.md` exists at the root, the repo is multi-context: read it to find which context's `CONTEXT.md` the current topic belongs to, and ask if unclear.

## Offer ADRs sparingly

Offer to record a decision as an ADR only when **all three** hold:

1. **Hard to reverse** - changing your mind later costs something real
2. **Surprising without context** - a future reader would wonder "why did they do it this way?"
3. **A real trade-off** - genuine alternatives existed and one was picked for specific reasons

If any is missing, skip it. Most sessions produce zero ADRs; that is working as designed.

ADRs live in `docs/adr/` (created lazily) as `NNNN-slug.md`, numbered by scanning for the highest existing number. The template is minimal:

```md
# {Short title of the decision}

{1-3 sentences: the context, what we decided, and why.}
```

Add Status frontmatter, Considered Options, or Consequences only when they genuinely add value.

Everything else the session decided lives only in the conversation. At the end, remind the user of this: if the plan should survive the session, turn the conversation into a spec before clearing it.

<!-- Condensed from https://github.com/mattpocock/skills (grill-with-docs = grilling + domain-modeling, MIT), self-contained to avoid the known partial-loading failure of the upstream dispatcher. -->
