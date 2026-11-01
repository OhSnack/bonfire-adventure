# Game Concept: Bonefire (working title)

*Created: 2026-10-30*
*Status: Draft*

Imported from the owner's design doc, "Spirit World Roguelike — Game Design Doc"
(Claude Docs, https://claude.ai/artifact/3XvzHUFUsdvJUYauQJYbac), which stays the
detailed record until per-system GDDs exist. Tags carried over: **Decided** = agreed,
**Proposed** = awaiting the owner's call, **Open** = not settled. Sections the doc
does not cover are marked *Open — for `/brainstorm`*; nothing here was invented.

**Placeholder terms (2026-10-30):** spirit = Ner, fragment = Nerling, memory piece = boss memory fragment.

**Setting change (Decided 2026-10-30):** the Jewish and Middle Eastern folklore is
dropped for an original world of flames and light. Character and enemy names below
(Nimrod, Ashmedai, the Angel of Death and so on) are placeholders for their roles
until renamed; their mechanics stay.

---

## Elevator Pitch

> It's a mobile roguelike deckbuilder where you fight turn-based card battles
> beside spirit companions in an original spirit world of flames and light,
> recovering lost memories to save someone you love, and discovering
> who you really are.

---

## Core Identity

| Aspect | Detail |
| ---- | ---- |
| **Genre** | Roguelike deckbuilder with overworld encounters |
| **Platform** | Cross-platform, landscape everywhere: Android and PC (itch.io) in early access; Steam, Epic and iOS by 1.0 |
| **Target Audience** | Teens and adults; likely around a 12+ store rating |
| **Player Count** | Single-player |
| **Session Length** | Target: full run 15–25 min (3 regions, about 5–8 min each), expected to grow as card picks and events are added; save-and-resume mid-run |
| **Monetization** | Free demo plus one-time unlock on mobile; paid with a free demo on PC; optional cosmetics with no gameplay effect |
| **Estimated Scope** | Large: solo developer at 3–12 h/week, planned by milestone, not by date |
| **Comparable Titles** | Slay the Spire, Hades, Revita |

---

## Core Fantasy

A small skeleton child crosses into the spirit world to save someone they love,
fighting beside soul-flame companions and visibly regaining life as their memories
return. Death is handled honestly but gently: warm but melancholic, like Hades,
Spiritfarer or Coco.

*This is the pre-reveal framing: what the player believes at the start. The truth is
in Narrative Premise below.*

---

## Narrative Premise

*Spoilers. Full canon: `design/narrative/narrative-bible.md`.*

The hero is the boy's dog, who followed the Angel of Death into the spirit world to
save the boy. He arrives as a skeleton child with scrambled memories: the shared
moments he recovers are real, but he believes he is the boy. A chained being of chaos
planted that lie to turn him against the Angel. The truth comes out when he finally
faces the Angel, before any ending is chosen. Memories and bonds persist across
failed runs, and colour returns because the memories are true.

---

## Unique Hook

It's like Slay the Spire, AND ALSO your companions (Nerlings, partial souls of the
spirits you free) charge from what the hero does and unleash automatically
mid-turn, so building a deck that sets off chain reactions between them is the core
skill, while recovered memories enter your deck as playable cards.

Nerlings in brief (Decided 2026-11-01; full rules in `design/gdd/systems-index.md`
#10, to be written up in the Nerlings GDD and validated by M1.5):
- Each Nerling charges from one kind of hero action, so the deck is the mechanism.
- Each bar gets harder every time it fires in a turn, so one fire is easy and long
  chains take a built deck.
- Nerlings can feed each other, and every loop ends on its own.
- One Nerling at the start of a run and a second in the first room; 5–8 unleashes a
  turn by region 3 is the skilled ceiling.

Scent (Decided 2026-10-31): the hero senses enemy intents and what lies behind the
next door through scent, the in-world reason intents and door previews exist. It is
shown only as spirit wisps, never as sniffing or nose imagery (reason: Narrative
Premise); see `design/art/art-bible.md`, Section 1, Dog-clue constraint.

---

## Visual Identity Anchor

**Each memory returns a little colour.** The world and the hero begin muted; every
recovered memory adds warmth, saturation or detail, and loss is shown as missing
colour, never as anything graphic. Supporting principles: combat information is
always at full strength; friends are round and threats angular; the hero is a
skeleton child whose hair warms as memories return. Full direction:
`design/art/art-bible.md`, Section 1.

---

## Player Experience Analysis (MDA Framework)

### Target Aesthetics
*Proposed ranking (drafted 2026-11-01 from the pillar order, owner to confirm):*
1. **Challenge**: building and executing Nerling chains against full intent.
2. **Narrative**: the reversed memories and the reveal.
3. **Discovery**: new Nerling families, Ashmedai's pools, ending paths.
4. **Expression**: deck-as-mechanism builds.

### Key Dynamics
- Building a deck as a mechanism: ordering cards so Nerlings unleash and feed each other into chains.
- Picking doors by their symbols to steer a run toward a Nerling family (resonance).
- Over-defending to build carried-over block (unproven: M1 players rarely played block; the combat GDDs decide).

### Core Mechanics
1. Turn-based card combat: 4 energy per turn, draw 6, full enemy intent, block carries over up to a cap (M1-tested).
2. Nerlings: freed from trapped Ners; per-Nerling triggers from the hero's actions; a bar that grows by a fixed step each time it fires in a turn; automatic unleash; five families (Ember, Tide, Mist, Root, Chaos). Rules: Unique Hook.
3. Run map: 3 regions × (3 rooms of 2 encounters + boss); after each room choose 1 of 3 doors; a card pick after every battle; events are room objects with a choice panel (see the design doc's Systems › Events); the Smith upgrades cards during runs only. At run end Embers are paid from elites, rooms and regions cleared, converted sparks and bonuses such as a no-damage fight, even when the run fails (systems index: Run-end payout & meta progression).
4. The haven: Embers buy haven upgrades and unlocks, never story, and are never sold for money; residents (Smith, Keeper, Nimrod; Ashmedai through a dark pool) have bonds that grow through NPC quests and repeat runs, not Embers, and unlock content and memories.
5. Key cards (Forgiveness, Dark Bargain) that decide the endings (five designed, 1–2 at 1.0) at the final battle with the Angel of Death.

---

## Player Motivation Profile

*Proposed (drafted 2026-11-01, owner to confirm):*
- **Competence**: deaths are explainable from visible intents and bars; chains reward
  planning. **Autonomy**: door choice, Nerling families, the starting-Nerling pick.
  **Relatedness**: resident bonds and the dog's loyalty.
- **Player types**: mainly Achievers (chain mastery, tiers) and Explorers (memories,
  holes, endings); little for Socializers or Killers, by design.
- **Flow**: short untimed turns, difficulty rising by region, tiers after the first
  full clear. No streaks or nagging.

---

## Core Loop

### Moment-to-Moment (30 seconds)
Play cards against a fully shown enemy intent, ordering them so Nerlings unleash and set each other off.

### Short-Term (about 2 minutes per room)
Clear a room's 2 encounters (battle, NPC or event), pick a card after each battle, free a trapped spirit for a fragment, upgrade or boon, then choose 1 of 3 doors.

### Session-Level (15-25 minutes, target)
A run across three regions to the Angel of Death; health persists across the run.

### Long-Term Progression
Embers spent at the haven grow the bonfire; resident bonds unlock mantles, Nerling families and memories; five endings designed (1–2 at 1.0); difficulty tiers by burning the bonfire lower after the first full clear.

### Retention Hooks
- **Curiosity**: what the memories hide; unlocked ending paths.
- **Investment**: resident arcs (Nimrod's coat, the Smith, the Keeper).
- **Mastery**: Nerling chains, mantles, difficulty tiers.

---

## Game Pillars

Priority when they conflict (Decided): tactics, then story, then accessibility (accessibility has no pillar of its own; it is a cross-cutting requirement).
Fairness is a fixed rule, not a trade-off.

### Pillar 1: Tactical, not luck-driven
Full enemy intent, fixed energy and a small curated deck: a deliberate move away from casino-style RNG.

*Design test*: between a random proc and a visible, plannable effect, choose the visible one.

Offers along a run match what the hero already has: a payoff is offered only with an enabler owned or paired in the same offer (systems index #14).

### Pillar 2: Spirits as partners
Nerlings charge from your actions and chain into combos.

*Design test (Proposed)*: a feature that makes Nerlings matter more to the plan beats one that adds hero power directly.

### Pillar 3: A story you earn
Memories return as you progress; the skeleton visibly regains life.

*Design test (Proposed)*: story progress is never lost on a failed run, and never bought with Embers.

### Pillar 4: Fair to players
No pay-to-win, no money-milking.

*Design test (Proposed)*: if a choice earns more by failing, quitting or paying than by playing well, change it.

### Anti-Pillars (What This Game Is NOT)
- **NOT pay-to-win or money-milking**: no loot boxes, no streaks, no fake scarcity (Proposed ethics list).
- **NOT real-time action**: no Dodge in the base game; battles stay untimed.
- **NOT graphic**: dark ideas through mood and suggestion only.

---

## Inspiration and References

| Reference | What We Take From It | What We Do Differently |
| ---- | ---- | ---- |
| Hades | Boons, haven dialogue, meta-progression, early-access model | Turn-based cards, not action |
| Slay the Spire | Cards, enemy intent | Auto-unleash companions, memories as cards |
| Revita | Memory story, pixel art | Story gated by bonds and key cards, not difficulty |
| Pokémon | Visible overworld encounters | Side-view card battles |
| Ori and the Blind Forest | Lighting | Pixel art with modern glow |

**Non-game inspirations**: universal motifs only (souls as flames, names hold
power, a soul for a soul); Spiritfarer and Hollow Knight scores; Coco.

---

## Target Player Profile

| Attribute | Detail |
| ---- | ---- |
| **Age range** | Teens and adults |
| **Time availability** | Short, often interrupted mobile sessions; longer PC sessions |
| **Platform preference** | Mobile first; PC |
| **What would turn them away** | Pay-to-win, streak pressure, deaths that feel unfair |

---

## Technical Considerations

| Consideration | Assessment |
| ---- | ---- |
| **Recommended Engine** | Godot 4 with GDScript (Decided); the repo pins 4.7 (latest patch 4.7.2) |
| **Key Technical Challenges** | Android and iOS export; one landscape layout across phone, tablet and PC; save-and-resume mid-turn |
| **Art Style** | Pixel art with modern lighting: isometric rooms, side-view battles, dialogue portraits |
| **Art Pipeline Complexity** | Medium: AI-first with a style guide and human cleanup (Decided guardrails) |
| **Audio Needs** | Moderate: warm acoustic and melancholic strings; no voice acting (Proposed) |
| **Networking** | None |
| **Content Volume** | 1.0: 3 regions, 2 mantles, first clear plus 1–2 endings (all 5 designed; the rest after 1.0) |
| **Procedural Systems** | Room paths and offers vary per run; layout randomization deferred to the replayability pass |

---

## Risks and Open Questions

### Design Risks
- **Top risk: the hook is unproven.** M1 tested one Nerling with one trigger; chains between Nerlings have never been played. Gate: a hook prototype (M1.5: 2 Nerlings, a deliberate 2-fire chain within the first 10 minutes, a chain turn resolving in about 8 s) must pass before M2 content is built. Planning chains on a phone needs a chain preview while dragging a card.
- The twist's clues need a budget: one hole per memory chapter, in dialogue or memory-card text, tied to memory unlock order, so repeated region 1 runs do not spoil it (Narrative Premise; art bible Section 1, Dog-clue constraint).
- Pacing: M1 fights take 30–55 s, which fits the 15–25 min target. Long chain turns add about 0.5 s per unleash; the speed toggle is required.
- Phone legibility: reading intents and Nerling state was M1's main friction on a phone (REPORT). The chain preview and bars must stay readable at phone size.
- Meeting Ashmedai depends on reaching region 3, so weaker players see Chaos later.
- The basic Ember fragment's payoff (3 Ignite) felt too small to make deliberate priming satisfying (M1).
- Key cards with Haunt and Linger sit in the opening hand of every normal fight; Forgiveness's Stun can stun-lock the Angel.

### Technical Risks
- The repo has no Android export setup; M0 needs Android running.

### Market Risks
*Proposed (drafted 2026-11-01, owner to confirm):*
- A crowded genre: deckbuilders after Slay the Spire and Balatro need a clear hook in the first minutes; the demo must show a chain.
- Paid mobile games with a free demo convert poorly next to free-to-play; store pages must sell the story and the hook.
- A solo developer's slow cadence can lose early-access interest.

### Scope Risks
- Hades-style portraits with 3–4 expressions each are the biggest art cost.
- 1.0 scope (3 regions, 2 mantles, 5 families, iOS, Steam and Epic) is large for one developer at 3–12 h/week; the owner may cut it, and the decision is theirs.

### Open Questions
Carried from the doc; the recommendations below were made on 2026-10-30 and are
Proposed until the owner decides.

| Question | Proposed recommendation |
| ---- | ---- |
| Do map enemies chase you? | No: static, facing enemies; touching from behind is an ambush |
| Energy carryover as a rare boon? | Yes: rare Tide boon, cap 1 |
| Do difficulty tiers unlock memories? | No: cosmetics and extra Embers only |
| Which two mantles at 1.0? | Sword and shield (beta), Bow (1.0) |
| Hammer, Spear, Gauntlets signatures | Stagger, Momentum, Conduit |
| Three regions and bosses | A great beast of the wilds, a mother of night, a forge-lord rival to the Smith |
| How is the opening night staged? | Closed: the game opens on crossing-night fragment 1 (Narrative Premise) |
| The hunter's endgame role | A rival hunter; the hunter finishes the coat and doesn't wear it |
| The Smith's identity | A smith spirit tied to the Eternal Furnace, source of Embers (owner's direction) |
| Bond path to Forgiveness | Open (two options: three bonds, or the hunter alone) |
| Prices per platform; beta test devices | Open |
| Whether Embers are kept on death | Closed: Embers are paid even when a run fails (systems index: Run-end payout & meta progression) |
| Sparks-to-Embers conversion rate | Open |

---

## MVP Definition

**Core hypothesis**: one battle with the stick deck and one auto-unleash Nerling is
fun to replay (M1 combat prototype).

**Required for MVP** (M1, as tested on 2026-10-30 to 31). All numbers below are
**provisional**: tuned in the prototype and sim, with no human loss on the latest
builds (v14–v15: 6 of 6 cleared, `prototypes/m1-combat-concept/REPORT.md`). GDDs must
not treat them as validated.
1. Battles with the 12-card starting deck (hero: 40 health, 4 energy, draw 6, block cap 3).
2. One enemy with full intent: the Hellhound (15 health; attack 4 + 1 Ignite + Weak 2 → attack 5 +
   1 Ignite + 6 block → attack 6 + 4 Ignite), in packs of 2 and 3.
3. One auto-unleash fragment: the Ember fragment (+1 charge per attack, fires at 3: all enemies get
   3 Ignite and Weak 1). M1 used a fixed threshold, not the stepped bar in Unique Hook.

**M1 result:** PROCEED, with the creative director's concern that the hook (Nerling chains; then, fragment priming) and
what sets the game apart are still untested. Card list, numbers and play logs are in the design
doc's Content tab and in `prototypes/m1-combat-concept/REPORT.md`.

**Explicitly NOT in MVP**: rooms and map, haven, mantles, endings.

### Scope Tiers

| Tier | Content |
| ---- | ---- |
| **MVP (M1)** | One battle |
| **Hook prototype (M1.5)** | Two Nerlings and a chain; gate before M2 (Design Risks) |
| **Vertical Slice (M2)** | One region, a boss, two Nerlings, one boon |
| **Public beta (M3)** | Polished first region, haven with two residents |
| **1.0** | Full run, two mantles, first clear plus one or two endings |

---

## Next Steps

- [x] `/setup-engine godot 4.7.2`
- [x] `/prototype` the M1 combat
- [x] `/map-systems`
- [ ] Re-run `/design-review` on this file, then `/gate-check systems-design`
- [ ] Hook prototype (M1.5)
- [ ] `/design-system` per system, starting with Content data format and Action pipeline & event bus
