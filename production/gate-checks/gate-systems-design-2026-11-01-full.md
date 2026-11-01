# Gate Check: Concept → Systems Design (full rigor)

**Date**: 2026-11-01
**Checked by**: gate-check skill
**Tier**: `workflow: full`, `review_mode: full`, `qa.level: full`, `team.size: studio` (all from `modes.rigor: full`)
**Supersedes**: `gate-systems-design-2026-11-01.md` (standard rigor, same day)

### Required Artifacts: 3/3 present
- [x] `design/gdd/game-concept.md` — exists with real content
- [x] Game pillars — 4 with a priority order, plus anti-pillars
- [x] Visual Identity Anchor in the concept (l.93) — "Each memory returns a little colour." + 3 principles

### Recommended
- [x] Concept prototype — `prototypes/m1-combat-concept/REPORT.md`, PROCEED

### Quality Checks: 4/4 passing
- [x] Concept reviewed — `design/gdd/reviews/game-concept-review-log.md`, latest entry APPROVED (fourth review)
- [x] Core loop described
- [x] Target audience identified
- [x] Anchor has a one-line rule and ≥2 principles

### Director Panel Assessment (4 of 4)

Creative Director: CONCERNS
  Pillar design tests 2–4, Target Aesthetics, Motivation Profile, Market Risks and the
  anti-pillar ethics list are Proposed drafts awaiting owner confirmation; pillar tests are
  the tie-breakers later GDDs are judged by. The hook is unproven until M1.5: write the
  Nerlings and combat GDDs as hypotheses and hold dependent content GDDs until it passes.

Technical Director: CONCERNS
  Feasibility shown in Godot 4.7.2. Android export is untested and must run before the
  Technical Setup gate. The Nerlings and Save GDDs should state determinism and
  serialization constraints for later ADRs.

Producer: CONCERNS
  The phase is unbounded (Design Order lists all 24 systems); record "this phase = the 9
  MVP systems". Full rigor costs an estimated 200–240 h of design for one developer at
  3–12 h/week (extrapolation). The systems index was made under lean review mode.

Art Director: READY
  The anchor meets the bar. Minor drift: "friends round, threats angular" comes from art
  bible §3, not §1. Decide memory-card text as a clue channel before the Memory and Card
  GDDs.

### Blockers
None.

### Concerns
1. Proposed concept drafts not yet owner-confirmed.
2. Hook unproven until M1.5.
3. Android export untested.
4. Phase unbounded; full rigor ≈ 200–240 h of design for one developer.
5. Systems index reviewed only under lean mode.
6. Art-bible follow-ups need art-director decisions (twist pointer, memory-card text channel, separate hole and clue budgets, "never in combat" scoped to clues).

### Verdict: CONCERNS
Stage unchanged (Concept). The owner will confirm the Proposed drafts in a fresh session
and re-run this gate.

Chain-of-Verification: 5 questions checked (3 by re-reading files) — verdict unchanged
