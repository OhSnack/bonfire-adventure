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
| **Session Length** | Full run 25–35 min before the final boss (3 regions, about 8–12 min each); save-and-resume mid-run |
| **Monetization** | Free demo plus one-time unlock on mobile; paid with a free demo on PC; optional cosmetics with no gameplay effect |
| **Estimated Scope** | Large: solo developer at 3–12 h/week, planned by milestone, not by date |
| **Comparable Titles** | Slay the Spire, Hades, Revita |

---

## Core Fantasy

A small skeleton child crosses into the spirit world to save someone they love,
fighting beside soul-flame companions and visibly regaining life as their memories
return. Death is handled honestly but gently: warm but melancholic, like Hades,
Spiritfarer or Coco.

---

## Unique Hook

It's like Slay the Spire, AND ALSO your companions (Nerlings, partial souls of the
spirits you free) charge from the cards you play and unleash automatically
mid-turn, so priming and chaining them is the core skill, while recovered memories
enter your deck as playable cards.

The twist (Decided): the hero is not the child but the child's dog, reshaped in the
crossing into the child's likeness.

Scent (Decided 2026-10-31): the hero senses enemy intents and what lies behind the
next door through scent, the in-world reason intents and door previews exist. It is
a dog trait, so it is shown only as spirit wisps and never as sniffing or nose
imagery; see `design/art/art-bible.md`, Section 1, Dog-clue constraint.

---

## Player Experience Analysis (MDA Framework)

### Target Aesthetics
*Open — for `/brainstorm`.* The doc's pillar priority implies Challenge (tactics)
first and Narrative second; the ranking is not yet written down.

### Key Dynamics
- Priming Nerlings one charge short of full and ordering cards to set off chains.
- Picking doors by their symbols to steer a run toward a Nerling family (resonance).
- Over-defending to build carried-over block.

### Core Mechanics
1. Turn-based card combat: 4 energy per turn, draw 6, full enemy intent, block carries over up to a cap (M1-tested).
2. Nerlings: freed from trapped Ners; per-Nerling charge triggers; automatic unleash; five families (Ember, Tide, Mist, Root, Chaos).
3. Run map: 3 regions × (3 rooms of 2 encounters + boss); after each room choose 1 of 3 doors; a card pick after every battle; events are room objects with a choice panel (see the design doc's Systems › Events); sparks (run currency) convert to Embers at run end.
4. The haven: residents (Smith, Keeper, Nimrod, Ashmedai) paid with Embers; bonds unlock content and memories.
5. Key cards (Forgiveness, Dark Bargain) that decide five endings at the final battle with the Angel of Death.

---

## Player Motivation Profile

*Open — for `/brainstorm`* (SDT needs, Bartle types, flow design). Doc inputs: fair
deaths players can explain, memory-driven story, no streaks or nagging.

---

## Core Loop

### Moment-to-Moment (30 seconds)
Play cards against a fully shown enemy intent, ordering them so Nerlings unleash at the right moment.

### Short-Term (5-15 minutes)
Clear a room's 2 encounters (battle, NPC or event), pick a card after each battle, free a trapped spirit for a fragment, upgrade or boon, then choose 1 of 3 doors.

### Session-Level (30-120 minutes)
A run across three regions to the Angel of Death; health persists across the run.

### Long-Term Progression
Embers spent at the haven grow the bonfire; resident bonds unlock mantles, Nerling families and memories; five endings; difficulty tiers by burning the bonfire lower after the first clear.

### Retention Hooks
- **Curiosity**: who the hero really is; unlocked ending paths.
- **Investment**: resident arcs (Nimrod's coat, the Smith, the Keeper).
- **Mastery**: Nerling chains, mantles, difficulty tiers.

---

## Game Pillars

Priority when they conflict (Decided): tactics, then story, then accessibility.
Fairness is a fixed rule, not a trade-off.

### Pillar 1: Tactical, not luck-driven
Full enemy intent, fixed energy and a small curated deck: a deliberate move away from casino-style RNG.

*Design test*: between a random proc and a visible, plannable effect, choose the visible one.

### Pillar 2: Spirits as partners
Nerlings charge from your actions and chain into combos.

### Pillar 3: A story you earn
Memories return as you progress; the skeleton visibly regains life.

### Pillar 4: Fair to players
No pay-to-win, no money-milking.

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
| **Content Volume** | 1.0: 3 regions, 2 mantles, 5 endings |
| **Procedural Systems** | Room paths and offers vary per run; layout randomization deferred to the replayability pass |

---

## Risks and Open Questions

### Design Risks
- Measured in M1, a regular battle takes 30–55 s (half the 1.5 min planned), so a region runs well under its 8–12 min budget; the pacing target needs restating.
- The basic Ember fragment's payoff (3 Ignite) felt too small to make deliberate priming satisfying (M1).
- Key cards with Haunt and Linger sit in the opening hand of every normal fight; Forgiveness's Stun can stun-lock the Angel.

### Technical Risks
- The repo has no Android export setup; M0 needs Android running.

### Scope Risks
- Hades-style portraits with 3–4 expressions each are the biggest art cost.

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
| How is the opening night staged? | 4 dog's-eye panels, replayed in the final act |
| The hunter's endgame role | A rival hunter; the hunter finishes the coat and doesn't wear it |
| The Smith's identity | A smith spirit tied to the Eternal Furnace, source of Embers (owner's direction) |
| Bond path to Forgiveness | Open (two options: three bonds, or the hunter alone) |
| Prices per platform; beta test devices | Open |
| Where the twist's dog clues live now that story events are cut | Open |
| Whether Embers are kept on death | Open |
| Sparks-to-Embers conversion rate | Open |

---

## MVP Definition

**Core hypothesis**: one battle with the stick deck and one auto-unleash Nerling is
fun to replay (M1 combat prototype).

**Required for MVP** (M1, as tested on 2026-10-30 to 31):
1. Battles with the 12-card starting deck (hero: 40 health, 4 energy, draw 6, block cap 3).
2. One enemy with full intent: the Hellhound (15 health; attack 4 + 1 Ignite + Weak 2 → attack 5 +
   1 Ignite + 6 block → attack 6 + 4 Ignite), in packs of 2 and 3.
3. One auto-unleash fragment: the Ember fragment (+1 charge per attack, fires at 3: all enemies get
   3 Ignite and Weak 1).

**M1 result:** PROCEED, with the creative director's concern that the hook (fragment priming) and
what sets the game apart are still untested. Card list, numbers and play logs are in the design
doc's Content tab and in `prototypes/m1-combat-concept/REPORT.md`.

**Explicitly NOT in MVP**: rooms and map, haven, mantles, endings.

### Scope Tiers

| Tier | Content |
| ---- | ---- |
| **MVP (M1)** | One battle |
| **Vertical Slice (M2)** | One region, a boss, two Nerlings, one boon |
| **Public beta (M3)** | Polished first region, haven with two residents |
| **1.0** | Full run, two mantles, first clear plus one or two endings |

---

## Next Steps

- [ ] `/setup-engine godot 4.7.2`: pass the engine explicitly; mobile renderer is a decision to make there
- [ ] `/brainstorm`: builds on this file and fills the Open sections
- [ ] `/prototype` the M1 combat
- [ ] `/map-systems`, then `/design-system` per system
