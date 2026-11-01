# Systems Index: Bonefire (working title)

> **Status**: Draft
> **Created**: 2026-11-01
> **Last Updated**: 2026-11-01
> **Source Concept**: design/gdd/game-concept.md

---

## Overview

Bonefire is a mobile-first roguelike deckbuilder: turn-based card battles against
fully shown enemy intents, fought beside Nerling companions that charge from what
happens in combat and unleash automatically. Its mechanical scope splits into five
groups. A **foundation** of a content data format, an ordered action pipeline with
an event bus, seeded randomness for draws and offers, game flow, save and input.
A **combat core** of turns and deck, health, block and statuses, enemies and
encounters, and Nerlings. A **run layer** of the map and doors, rooms, events,
rewards and deck changes, Smith card upgrades, and sparks with the merchant. A
**story and meta layer** of story state, memories, bonds, key cards and endings,
and the run-end payout feeding the haven. And **presentation** systems on top.
Pillar 1 (tactical, not luck-driven) shapes the foundation: effects are never
random, and only draw order, offers and paths vary per run, from a seed. Pillar 2
(spirits as partners) makes the action pipeline the central system, because every
Nerling trigger listens to its events.

**System notes (balanced density):**

- **1 Content data format** — how cards, enemies, statuses, Nerlings, boons and events are stored as data: the format only. The actual cards and enemies are designed after the combat rules. Includes validation (every ID resolves) and the localization convention: every player-facing string is a translation key from day one.
- **2 Action pipeline & event bus** — every effect enters one ordered queue. Owner decision (2026-11-01): the order is the card's effect, then card events (played, drawn, discarded and the like), then companion reactions, with triggers at turn start as well. Resolved effects emit typed events (damage dealt, status applied, card drawn, turn started…) that Nerlings, statuses and boons subscribe to. Owns targeting, keywords, chain order and the safe point for saving (an empty queue).
- **3 Seeded RNG** — one run seed with separate streams for draws, rewards and offers, map and events, so a resumed run gets identical draws and offers. Owner decision: no effect is ever random; only the shuffle, offers and paths vary per run.
- **4 Game flow & run state** — the flow haven → run → room → combat → reward → door → run end. Run state owns hero health, sparks and the run config (difficulty modifiers).
- **5 Save & resume** — mid-turn resume plus meta save. Each system provides its own data snapshot; save never reaches into internals.
- **6 Input & platform** — touch first, mouse, partial gamepad; long-press on touch equals hover on PC.
- **7 Turn, energy & deck** — turn phases (including when statuses tick), 4 energy, draw 6, piles, Fade, reshuffle.
- **8 Health, block & statuses** — damage, block carried over up to a cap, and status stacks (Ignite, Weak; later Stun, Haunt, Linger).
- **9 Enemies & encounters** — intent cycles, the enemy-turn forecast (a dry run of the enemy turn on a copy of the state), packs, win and loss, elites, bosses and the Angel of Death.
- **10 Nerlings** — each Nerling is data: a trigger (any pipeline event plus a filter), a charge threshold, an unleash effect and a family (Ember, Tide, Mist, Root, Chaos). Owner decision: a companion may trigger more than once a turn; rather than a hard cap, each trigger in a turn raises the charge needed for the next, so firing once is easy and firing five times is very hard. Owner decision: Chaos has wild effects and unusual charge triggers, never randomness. Owner decisions 2026-11-01 (numbers provisional, validated by M1.5): triggers come mostly from hero actions, and another Nerling's unleash counts as an action. *Action* Nerlings gain 1 charge per qualifying action (a card or an unleash counts once, whatever its hits or targets); *amount* Nerlings count totals (damage, block, healing). Each bar has a start size and a step, grows by its step each time it fires in a turn, and returns to its start size next turn (demo Ember: start 2, step 1). One input fires a bar at most once; overflow is discarded. Output never grows within a turn, and the step is a whole number of at least 1, so loops end; an engineering fail-safe sits beyond legal play. Leftover charge carries to the next turn, capped one short of the start size; charge resets each fight. One Nerling at run start, a second in the first room; 5–8 unleashes per turn across 3 Nerlings by region 3 is the ceiling, and bosses bring spawns. A speed toggle and tap-to-skip are required (owned by #21 Combat UI). Chaos Nerlings come only from Ashmedai's dark pools (narrative bible). Proposed: choose the starting Nerling at the haven. Nerling offers follow the enabler rule in #14.
- **11 Run map & doors** — regions, rooms of 2 encounters, a boss per region, a choice of 1 of 3 doors, door symbols and resonance. A pure graph, kept apart from room exploration so it can be tested.
- **12 Room exploration** — isometric rooms, visible static enemies, ambush when touched from behind.
- **13 Events & NPCs** — room objects with a choice panel; the event pool. Offers rewards through system 14 rather than defining its own rules.
- **14 Run rewards & deck changes** — the single owner of card picks (after every battle), card removal, spirit rescue (fragment, upgrade or boon), boons as passive run items on the event bus, and healing and rest. Owner decision 2026-11-01: offers match what the hero already has. A payoff (a card, Nerling or boon that needs a condition, such as a Nerling that triggers on Weak) is offered only if the hero owns an enabler for it (a card or Nerling that applies Weak), or if it comes paired with one as a single option taken together. Enablers are always eligible. This applies to every offer source: card picks, spirit rescue, the merchant and Ashmedai's pools.
- **15 Card upgrades (Smith)** *(owner addition)* — the Smith adds effects or keywords to existing cards. Owner decision: during runs only.
- **16 Sparks & merchant** — run currency in and out; the shop's stock and prices (cards, removal, run upgrades, healing).
- **17 Story state** *(inferred)* — lasting flags across runs (memories, clues seen, bond stages, key cards, endings reached) and a query API other systems read.
- **18 Memories, bonds, key cards & endings** — a memory unlock grants a card, raises the colour stage (art bible Section 4) and plays a scene. Owner decision: bonds grow through story beats, not Embers. Key cards (Forgiveness, Dark Bargain) and the five endings at the Angel.
- **19 Run-end payout & meta progression** — owner decision: Embers come from elites, rooms and regions completed, plus sparks converted, plus bonuses such as finishing a fight without taking damage. They are shown on a run-end screen and paid even when a run fails. Embers buy haven upgrades; this system also covers mantle unlocks and difficulty tiers. Owner decisions 2026-11-01: a failed run always pays less than a clear on the same route; the first "win?" arrival at the locked Angel door pays like a clear once per profile, later arrivals at the normal rate; Embers never buy memories, endings or key cards and are never sold for money; difficulty tiers unlock on the first full clear. Proposed: the economy is finite by design, with cosmetics as the only open-ended sink. Owner decision: paid cosmetics and Ember cosmetics are separate catalogs that never overlap.
- **20 Story scene player** — dialogue with 3–4 portrait expressions, the opening panels if adopted, and memory and ending scenes.
- **21 Combat UI** — hand, drag-to-play, intents, forecast, Nerling charge and chain feedback. Read-only; it sends play intents and draws state.
- **22 Run & meta UI** — door badges with family medallions (art bible Section 3), event panels, shop, haven, deck view, run-end screen, settings.
- **23 Audio** — music and SFX, driven by pipeline events.
- **24 Accessibility & onboarding** — reduced motion, colourblind backups, text size, and teaching intents, Nerlings and priming.

**Not systems (recorded on purpose):** localization is a convention in system 1;
store unlock and demo is a release task for M3; analytics is not planned; the
Android and iOS export is a devops task for M0.

---

## Systems Enumeration

| # | System Name | Category | Priority | Status | Design Doc | Depends On |
|---|-------------|----------|----------|--------|------------|------------|
| 1 | Content data format (inferred) | Core | MVP | Not Started | — | — |
| 2 | Action pipeline & event bus (inferred) | Core | MVP | Not Started | — | Content data format |
| 3 | Seeded RNG (inferred) | Core | MVP | Not Started | — | — |
| 4 | Game flow & run state (inferred) | Core | Vertical Slice | Not Started | — | Content data format |
| 5 | Save & resume | Persistence | Vertical Slice | Not Started | — | Seeded RNG, Game flow & run state, Story state; snapshots from 7–10 |
| 6 | Input & platform (inferred) | Core | MVP | Not Started | — | — |
| 7 | Turn, energy & deck | Gameplay | MVP | Not Started | — | Action pipeline, Seeded RNG |
| 8 | Health, block & statuses (inferred) | Gameplay | MVP | Not Started | — | Action pipeline |
| 9 | Enemies & encounters | Gameplay | MVP | Not Started | — | Action pipeline; Turn, energy & deck; Health, block & statuses |
| 10 | Nerlings | Gameplay | MVP | Not Started | — | Action pipeline; Health, block & statuses |
| 11 | Run map & doors | Gameplay | Vertical Slice | Not Started | — | Seeded RNG, Game flow & run state |
| 12 | Room exploration | Gameplay | Vertical Slice | Not Started | — | Run map & doors, Enemies & encounters |
| 13 | Events & NPCs | Gameplay | Vertical Slice | Not Started | — | Run rewards & deck changes, Sparks & merchant, Story state |
| 14 | Run rewards & deck changes | Progression | Vertical Slice | Not Started | — | Seeded RNG; Game flow & run state; Turn, energy & deck; Nerlings |
| 15 | Card upgrades (Smith) | Progression | Alpha | Not Started | — | Content data format, Run rewards & deck changes |
| 16 | Sparks & merchant | Economy | Alpha | Not Started | — | Run rewards & deck changes |
| 17 | Story state (inferred) | Narrative | Vertical Slice | Not Started | — | Content data format |
| 18 | Memories, bonds, key cards & endings | Narrative | Alpha | Not Started | — | Story state, Run rewards & deck changes |
| 19 | Run-end payout & meta progression | Progression | Alpha | Not Started | — | Game flow & run state; Sparks & merchant; Memories, bonds, key cards & endings |
| 20 | Story scene player (inferred) | Narrative | Alpha | Not Started | — | Story state; Memories, bonds, key cards & endings |
| 21 | Combat UI (inferred) | UI | MVP | Not Started | — | Turn, energy & deck; Health, block & statuses; Enemies & encounters; Nerlings; Input & platform |
| 22 | Run & meta UI (inferred) | UI | Vertical Slice | Not Started | — | Systems 11–19, Input & platform |
| 23 | Audio (inferred) | Audio | Alpha | Not Started | — | Action pipeline (events) |
| 24 | Accessibility & onboarding (inferred) | Meta | Alpha | Not Started | — | Combat UI, Run & meta UI |

Notes on the table:
- **Events & NPCs (13)** is in the Vertical Slice but lists one Alpha system, Sparks & merchant (16), among its dependencies. In the slice, events offer rewards from system 14 and read Story state (17); shop hooks join once system 16 is designed.
- **Run & meta UI (22)** grows with each tier for the same reason.

---

## Categories

| Category | Description | Typical Systems |
|----------|-------------|-----------------|
| **Core** | Foundation systems everything depends on | Content data format, action pipeline, seeded RNG, game flow, input |
| **Gameplay** | The systems that make the game fun | Turns and deck, statuses, enemies, Nerlings, map, rooms, events |
| **Progression** | How the player grows over time | Run rewards, Smith upgrades, run-end payout and meta progression |
| **Economy** | Resource creation and consumption | Sparks and the merchant |
| **Persistence** | Save state and continuity | Save and resume |
| **UI** | Player-facing information displays | Combat UI, run and meta UI |
| **Audio** | Sound and music systems | Audio |
| **Narrative** | Story and dialogue delivery | Story state, memories and endings, scene player |
| **Meta** | Systems outside the core game loop | Accessibility and onboarding |

---

## Priority Tiers

| Tier | Definition | Target Milestone | Design Urgency |
|------|------------|------------------|----------------|
| **MVP** | Required for the core loop to function. Without these, you can't test "is this fun?" | One production-quality battle (the M1 battle rebuilt on real systems) | Design FIRST |
| **Vertical Slice** | Required for one complete, polished area. Demonstrates the full experience. | M2: one region, a boss, two Nerlings, one boon, plus a thin slice: one memory card, one colour stage and a short Nerling-priming tutorial (the full Memories #18 and Onboarding #24 systems stay in Alpha) | Design SECOND |
| **Alpha** | All features present in rough form. Complete mechanical scope, placeholder content OK. | M3 public beta: polished region 1, haven with two residents | Design THIRD |
| **Full Vision** | Polish, edge cases, nice-to-haves, and content-complete features. | 1.0: 3 regions, 2 mantles, first clear plus 1–2 endings (5 designed), difficulty tiers. No new systems; content on the systems above | Design as needed |

> **Review notes (2026-11-01, full):** TD-SYSTEM-BOUNDARY CONCERNS, PR-SCOPE OPTIMISTIC,
> CD-SYSTEMS CONCERNS. None blocks; resolved by the owner's decisions above (phase
> target, provisional Nerlings, Story state moved to the Vertical Slice, thin M2 story
> slice). These reviews were skipped under lean mode when the index was written; an
> informal review then merged 31 drafts to 24 (see the Overview). Requirements on the MVP GDDs:
> - **#2 Action pipeline:** one snapshot/restore contract shared by the #9 forecast dry run and #5 Save. A dry run must not emit events or use RNG. Keep the keyword catalogue separate from the queue. Boon runtime uses the #2 listener model; #14 owns only the offers.
> - **#1 Content data format:** reserve the enabler and payoff tags (#14's rule).
> - **#7–#10:** each GDD has a section on the state it serializes.
> - **#8 Health, block & statuses:** owns hero HP during combat and hands it to #4 at combat boundaries.
> - **#10 Nerlings:** decide chain preview versus readable bars (Pillars 1 and 2). Write it as a hypothesis until M1.5.
> - **#21 Combat UI:** owns the speed toggle and tap-to-skip (moved from #10), and reserves reduced-motion hooks for #24.
>
> **For later tiers:** #15 and #16 prefer upgrades that change chain math over flat numbers (Pillar 2 test). #12's ambush needs a stated pillar purpose and must stay visible and avoidable. NPC quests (bonds) need an owner, #13 or #18.

---

## Dependency Map

### Foundation Layer (depends only on other foundation systems)

1. Content data format — every rule and piece of content is read from it.
2. Seeded RNG — fair, reproducible draws and offers that a resume can recreate.
3. Input & platform — touch-first input that every interactive system receives.
4. Action pipeline & event bus — depends on: Content data format. Designed as a pair with it, because the format must express what the pipeline runs.
5. Game flow & run state — depends on: Content data format.
6. Story state — depends on: Content data format.

### Core Layer (depends on foundation)

1. Turn, energy & deck — depends on: Action pipeline, Seeded RNG
2. Health, block & statuses — depends on: Action pipeline
3. Nerlings — depends on: Action pipeline; Health, block & statuses
4. Enemies & encounters — depends on: Action pipeline; Turn, energy & deck; Health, block & statuses
5. Save & resume — depends on: Seeded RNG, Game flow & run state, Story state; data snapshots from the combat systems

### Feature Layer (depends on core)

1. Run map & doors — depends on: Seeded RNG, Game flow & run state
2. Run rewards & deck changes — depends on: Seeded RNG; Game flow & run state; Turn, energy & deck; Nerlings
3. Card upgrades (Smith) — depends on: Content data format, Run rewards & deck changes
4. Sparks & merchant — depends on: Run rewards & deck changes
5. Events & NPCs — depends on: Run rewards & deck changes, Sparks & merchant, Story state
6. Room exploration — depends on: Run map & doors, Enemies & encounters
7. Memories, bonds, key cards & endings — depends on: Story state, Run rewards & deck changes
8. Run-end payout & meta progression — depends on: Game flow & run state; Sparks & merchant; Memories, bonds, key cards & endings

### Presentation Layer (depends on features)

1. Combat UI — depends on: the combat core systems, Input & platform
2. Run & meta UI — depends on: the feature systems, Input & platform
3. Story scene player — depends on: Story state; Memories, bonds, key cards & endings
4. Audio — depends on: Action pipeline events

### Polish Layer (depends on everything)

1. Accessibility & onboarding — depends on: Combat UI, Run & meta UI

**Bottlenecks:**
- Action pipeline & event bus: every combat system, boons and audio plug into it.
- Content data format.
- Game flow & run state.
- Story state.

**Leaf systems** (nothing depends on them): Audio, Accessibility & onboarding, Story scene player.

---

## Recommended Design Order

> **Phase scope (Decided 2026-11-01):** the Systems Design phase covers only the 9
> MVP systems, orders 1–8 below (order 1 is a pair). It ends when those 9 GDDs are
> approved. Orders 9 onward are designed when their milestone starts (Vertical Slice,
> Alpha, 1.0), not in this phase. Reason: the producer's gate concern that designing
> all 24 at full rigor is about 200–240 h for one developer
> (`production/gate-checks/gate-systems-design-2026-11-01-full.md`).
> Target: about 14 weeks at ~7 h/week. Checkpoint after order 1: compare real hours
> with the estimate (80–100 h for the phase) and re-plan. The Nerlings GDD (order 5)
> is written in order, but its Formulas and Tuning Knobs stay provisional, and it
> cannot be fully approved, until M1.5 passes.

| Order | System | Priority | Layer | Agent(s) | Est. Effort |
|-------|--------|----------|-------|----------|-------------|
| 1 | Content data format + Action pipeline & event bus (as a pair) | MVP | Foundation | systems-designer, technical-director | L |
| 2 | Seeded RNG | MVP | Foundation | technical-director | S |
| 3 | Turn, energy & deck | MVP | Core | game-designer | M |
| 4 | Health, block & statuses | MVP | Core | systems-designer | M |
| 5 | Nerlings | MVP | Core | game-designer, systems-designer | L |
| 6 | Enemies & encounters | MVP | Core | game-designer, ai-programmer | M |
| 7 | Input & platform | MVP | Foundation | ux-designer | S |
| 8 | Combat UI | MVP | Presentation | ux-designer, ui-programmer | M |
| 9 | Game flow & run state | Vertical Slice | Foundation | technical-director | S |
| 10 | Story state | Vertical Slice | Foundation | narrative-director, technical-director | S |
| 11 | Save & resume | Vertical Slice | Core | technical-director | M |
| 12 | Run map & doors | Vertical Slice | Feature | level-designer, game-designer | M |
| 13 | Run rewards & deck changes | Vertical Slice | Feature | game-designer, economy-designer | M |
| 14 | Events & NPCs | Vertical Slice | Feature | game-designer, writer | M |
| 15 | Room exploration | Vertical Slice | Feature | level-designer | M |
| 16 | Run & meta UI | Vertical Slice | Presentation | ux-designer | M |
| 17 | Memories, bonds, key cards & endings | Alpha | Feature | narrative-director, game-designer | L |
| 18 | Sparks & merchant | Alpha | Feature | economy-designer | M |
| 19 | Card upgrades (Smith) | Alpha | Feature | systems-designer | M |
| 20 | Run-end payout & meta progression | Alpha | Feature | economy-designer | M |
| 21 | Story scene player | Alpha | Presentation | narrative-director, ui-programmer | S |
| 22 | Audio | Alpha | Presentation | audio-director | S |
| 23 | Accessibility & onboarding | Alpha | Polish | accessibility-specialist, ux-designer | M |

---

## Circular Dependencies

- None found. Two would-be cycles are broken by contract:
  - Save does not reach into other systems; each one provides a data snapshot.
  - Story state is only read by other systems, never written into them; memories write the flags, and the deck, endings and colour grade read them.

---

## High-Risk Systems

| System | Risk Type | Risk Description | Mitigation |
|--------|-----------|-----------------|------------|
| Action pipeline & event bus | Design / Technical | Trigger order, a companion firing repeatedly with rising charge costs, and runaway chains (an unleash dealing damage that charges another Nerling) | Design it first, as a pair with the data format; unit-test the order; prototype chains before content is written |
| Nerlings | Design | The hook (priming and chaining) is untested; the creative director's M1 concern | A hook-focused prototype early, using the pipeline |
| Save & resume | Technical | Exact mid-turn resume needs the RNG streams, an empty queue and per-system snapshots | Save only at an empty queue; round-trip tests |
| Story state, memories and the twist | Design | Twist clues must stay subtle (art bible dog-clue constraint), and their pacing across runs is unproven | Clue flags tracked per run; playtesters who don't know the twist |
| Memory colour stages (art bible) | Technical | A world-only colour grade must leave icons and UI untouched, in both the Mobile and Compatibility renderers | A technical-artist spike before the Vertical Slice |

---

## Progress Tracker

| Metric | Count |
|--------|-------|
| Total systems identified | 24 |
| Design docs started | 0 |
| Design docs reviewed | 0 |
| Design docs approved | 0 |
| MVP systems designed | 0/9 |
| Vertical Slice systems designed | 0/8 |

---

## Next Steps

- [ ] Review and approve this systems enumeration
- [ ] Design MVP-tier systems first (use `/design-system [system-name]`)
- [ ] Run `/design-review` on each completed GDD
- [ ] Run `/gate-check technical-setup` when MVP systems are designed
- [ ] Validate the highest-risk systems with `/vertical-slice` before committing to Production
