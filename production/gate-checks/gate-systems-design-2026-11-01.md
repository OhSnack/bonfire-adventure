# Gate Check: Concept → Systems Design

**Date**: 2026-11-01
**Checked by**: gate-check skill
**Tier**: `workflow: standard`, `review_mode: lean`, `qa.level: standard`

### Required Artifacts: 1/1 present
- [x] `design/gdd/game-concept.md` — exists with real content (pitch, core loop, pillars, audience, MVP, scope tiers)

### Recommended (standard tier; absent = CONCERNS)
- [x] Game pillars — 4 pillars plus anti-pillars in the concept
- [~] Visual Identity Anchor — present in `design/art/art-bible.md` §1 (rule "Each memory returns a little colour." + 3 principles), not in the concept
- [x] Concept prototype — `prototypes/m1-combat-concept/REPORT.md`, PROCEED (CD-PLAYTEST concerns accepted)

### Quality Checks: 3/4 passing
- [ ] Concept reviewed via `/design-review` — not yet (owner, 2026-11-01)
- [x] Core loop described (moment-to-moment through long-term)
- [x] Target audience identified
- [x] Visual rule + ≥2 supporting principles (art bible §1)

### Director Panel Assessment (2 of 4, `workflow: standard`)

Technical Director: CONCERNS
  Feasibility shown by M1 (Godot 4.7.2, GDScript). Mobile export unproven: no Android
  preset; smoke-build Android before the Save & resume GDD hardens. Visual anchor needs
  a cross-reference from the concept. No performance budgets yet — fine at this phase.

Producer: CONCERNS
  Full design order ≈ 160 h (low-confidence estimate) = 13–50 weeks at 3–12 h/week;
  scope this phase to the 9 MVP systems (≈ 60 h). Hook-focused prototype has no slot
  in the design order. 1.0 scope conflict (5 endings vs 1–2). No concept review.

Creative and Art perspectives not consulted. Raise `modes.rigor` to `full` for the full panel.

Verified by re-reading: the hook prototype appears only as a mitigation
(`systems-index.md:221`). The 1.0 conflict is inside `game-concept.md`: Content Volume
says "3 regions, 2 mantles, 5 endings" (copied into the systems index); Scope Tiers says
"first clear plus one or two endings".

### Blockers
None.

### Concerns
1. Concept has no `/design-review`.
2. 1.0 ending count contradicts itself within the concept.
3. Hook-focused prototype unscheduled relative to the Nerlings GDD (design order 5).
4. Design order scoped to the whole game rather than the next milestone.
5. Android export untested.
6. Visual Identity Anchor lives in the art bible, not the concept.

### Recommendations
- `/design-review design/gdd/game-concept.md`, settling the 1.0 ending count, then re-run `/gate-check systems-design`.
- Slot the hook prototype before or right after the Nerlings GDD.
- Limit Systems Design to the MVP systems.

### Verdict: CONCERNS
Stage unchanged (Concept); the owner chose to run `/design-review` on the concept first.

Chain-of-Verification: 5 questions checked — verdict unchanged
