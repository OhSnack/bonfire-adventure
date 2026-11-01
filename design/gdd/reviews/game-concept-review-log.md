# Review log — design/gdd/game-concept.md

## Review — 2026-11-01 — Verdict: NEEDS REVISION
Review mode: full · Workflow: full
Scope signal: n/a (concept, not a system)
Specialists: game-designer, systems-designer, economy-designer, narrative-director; senior: creative-director
Blocking items: 7 | Recommended: 10
Summary: Coherent at identity level (fantasy, twist, pillars hold together), but the concept contradicts itself and the systems index, and its stated hook predates the per-Nerling trigger decision. Fixes inside the concept, not a re-concept. Formula, price and rule items routed to per-system GDDs.
Prior verdict resolved: First review (a lean pass earlier the same day wrote no log)
Findings:
- [BLOCKING] Unique Hook / Pillar 2 / Key Dynamics / Core Loop: "charge from cards played" predates per-Nerling triggers (index #10); state chain length; hook unproven = top risk with a pre-M2 gate
- [BLOCKING] Core Mechanics / Long-Term / Content Volume / Scope Tiers: 1.0 ending count 5 vs 1–2 (also systems-index l.118)
- [BLOCKING] Core Loop Session-Level: 30–120 min vs 25–35 min run; restate from M1 30–55 s fights
- [BLOCKING] Core Mechanics / Open Questions: Embers–Smith–bonds wording stale vs index #15, #18, #19; close Embers-on-death
- [BLOCKING] Core Fantasy: add a Narrative Premise (loved one, dog–child relationship, pre-reveal label, memories/bonds persist across failed runs)
- [BLOCKING] Open Questions: twist clue vehicle missing; move to Design Risks with candidate vehicles
- [BLOCKING] MVP Definition: mark 40 HP, draw 6, Hellhound numbers provisional (no human loss on v14–v15, REPORT l.116)
- [RECOMMENDED] Game Pillars: priority list names accessibility, no pillar covers it
- [RECOMMENDED] Key Dynamics: over-defending dynamic contradicted by M1
- [RECOMMENDED] Core Mechanics: ~21 picks vs small curated deck
- [RECOMMENDED] Risks: phone legibility missing; Market Risks missing; 1.0 scope size as a Scope Risk
- [RECOMMENDED] Anti-Pillars: meta never buys combat power (owner to confirm)
- [RECOMMENDED] Setting: rename Nimrod, Ashmedai, Angel of Death before scene writing
- [RECOMMENDED] Elevator Pitch: "who you really are" leans on the twist
- [RECOMMENDED] Next Steps: stale
- [ROUTED] Action pipeline + Nerlings: charge-cost formula/reset, chain depth/termination, Chaos "never random" scope, fragment payoff target
- [ROUTED] Turn/energy/deck + Health/block/statuses: block cap, reshuffle, hand cap, empty pile, 0 energy, cost curve, Ignite tick, AoE scaling
- [ROUTED] Game flow & run state: HP budget per region, run-length maths
- [ROUTED] Sparks & merchant + Run-end payout: Ember sinks/targets, death-farming, conversion, prices, ethics list
- [ROUTED] Memories/bonds/key cards/endings: key cards in opening hand, Forgiveness stun-lock, bond path to Forgiveness
- [ROUTED] Combat UI: charge and chain forecast
Rulings: hook is a core-skill change (M1.5 prototype is the owner's call); twist stays Decided; 1.0 cut is the owner's call (Scope Risk only); economy index-numbering claim dismissed (layer lists number per layer).
Reviewed-Content-Hash: design/gdd/game-concept.md 250ed6b3e24f3bd996ddcdc09afbf65a738ff7d1
Reviewed-Content-Hash: design/registry/entities.yaml dfeacb02917f751cb1dfd88cf490c7ec3d8d2d0f
Reviewed-Content-Hash: .claude/skills/design-review/SKILL.md a63d8fba9b7142eeb43791f061e2e1533c429b43
Reviewed-Content-Hash: design/gdd/systems-index.md df7e6a27a83f41266e9f1a4ca22e3784911a0cdc
Reviewed-Content-Hash: prototypes/m1-combat-concept/REPORT.md 0ecf275264d18112d717be5e2781442bcdb1d31c
Reviewed-Content-Hash: prototypes/m1-combat-concept/README.md 0e81c8f8786408faac3c8e83263d843a747ed88c

## Review — 2026-11-01 (second) — Verdict: NEEDS REVISION
Review mode: full · Workflow: full
Scope signal: n/a (concept, not a system)
Specialists: game-designer, systems-designer, economy-designer, narrative-director; senior: creative-director
Blocking items: 8 | Recommended: 9
Summary: Six of seven prior blockers closed. Remaining: a pronoun-rule contradiction introduced in revision, a farmable "win?" payout, an unbounded loop path through output scaling, twist leaks via Ashmedai and memory-card text, and gate sections missing at workflow full. Fixed in 021afbf after owner decisions; detail moved to design/narrative/narrative-bible.md and systems-index #10, #14, #19.
Prior verdict resolved: Partly (6 of 7)
Findings:
- [BLOCKING] Narrative Premise: pronoun rule contradicted its example (fixed: crossing night has no swap; Ashmedai's single planted line)
- [BLOCKING] Core Mechanics: "win?" payout not once-only; failure vs clear pay; Ember sink (fixed in index #19; finite economy Proposed)
- [BLOCKING] Narrative Premise / Long-Term: tier unlock stated two ways (fixed: first full clear, owner overrode the CD's advice)
- [BLOCKING] Unique Hook: output growth could break loop termination (fixed: output never grows within a turn; step >= 1)
- [BLOCKING] Unique Hook: carry-over could zero small bars (fixed: start + step bars, leftover charge carries capped one short of start)
- [BLOCKING] Narrative Premise: Ashmedai's defeat and memory-card text could leak the twist (fixed: gated after the first Angel dialogue; hole text off the in-combat card face)
- [BLOCKING] Narrative Premise: Ashmedai's first appearance (fixed: first room of the first region 3 visit, after the region 2 lie)
- [BLOCKING] Gate sections: Visual Identity Anchor, aesthetics, motivation, market risks, pillar tests, M1.5 tier, Next Steps (added; drafts marked Proposed)
- [RECOMMENDED] routed: overflow, slot cap, chain preview, payout rates, Ashmedai offer costs, hunter quest recast, art-bible clue-channel updates
Reviewed-Content-Hash: design/gdd/game-concept.md 29bcdaddd5575eff1f90ec30b6aa79c3cc06304c
Reviewed-Content-Hash: design/registry/entities.yaml dfeacb02917f751cb1dfd88cf490c7ec3d8d2d0f
Reviewed-Content-Hash: .claude/skills/design-review/SKILL.md a63d8fba9b7142eeb43791f061e2e1533c429b43
Reviewed-Content-Hash: design/gdd/systems-index.md d88a0b5ec56c0a3f6a022817a689512e3da5847b
Reviewed-Content-Hash: design/art/art-bible.md 4e68264977eab2f43f6ce886965462089879df5d
Reviewed-Content-Hash: prototypes/m1-combat-concept/REPORT.md 0ecf275264d18112d717be5e2781442bcdb1d31c
Reviewed-Content-Hash: prototypes/m1-combat-concept/README.md 0e81c8f8786408faac3c8e83263d843a747ed88c
