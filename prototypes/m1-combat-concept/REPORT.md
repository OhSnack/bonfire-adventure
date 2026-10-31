<!-- PROTOTYPE - NOT FOR PRODUCTION -->
<!-- Question: does ordering cards to prime the Ember fragment against Hellhounds with visible intent create real decisions? -->
<!-- Date: 2026-10-31 -->
# Concept Prototype Report: M1 combat (Bonefire)

> **Date**: 2026-10-31
> **Prototype Path**: Engine (Godot 4.7.2, GDScript), played as a web build in a private Claude artifact
> **Concept File**: design/gdd/game-concept.md

---

## Hypothesis

If the player orders the deck's cards to prime and fire the Ember fragment against Hellhounds with
visible intent, they will feel in tactical control, evidenced by: a fight ending in about 90 seconds,
sensible play clearly beating careless play, and the player wanting another fight.

---

## Riskiest Assumption Tested

That the fragment's automatic unleash is readable and creates real priming decisions at that pace.

**Outcome: not yet proven.** The fragment fired 1–2 times per fight, but the owner did not plan around
it. On a phone the first build drew in a small part of the screen and the intents and fragment were
hard to read. After the readability pass (v12–v13) the logs show some deliberate use (spreading
attacks across three hounds so the all-enemy unleash hit each), but the owner still describes the
fragment as weak.

---

## Approach

A throwaway Godot project in `prototypes/m1-combat-concept/`, iterated over 14 published builds in two
days (2026-10-30 to 2026-10-31) with an automatic-battle script (`sim.gd`) to test balance between
builds. The final build is a three-fight run (2, 2, then 3 Hellhounds) with a card pick after
fights 1 and 2, HP carried over with a 4 HP heal, and a play log the owner copies into the chat.

**Path chosen:** Engine
**Reason for path:** the owner asked to install Godot and build in the project's engine; a web export
let the owner play on a phone without installing anything.

**Shortcuts taken (intentional):**
- Placeholder boxes and text; no art, sound or animation.
- Hardcoded numbers in `battle.gd`; no data files.
- Reward pool is only the starting cards; spirits (fragments, boons) exist only in `sim.gd`.
- The web build ships a gzipped engine file and embeds the game data, to fit the artifact host.
- Debug key W wins the current fight (marked in the log).

---

## Result

**Play logs:** 7 complete runs by the owner on a phone (4 on v11, 3 on v12).

- Cleared 2 of 7 runs. Every one of the 5 deaths was Ignite burn in the 3-Hellhound fight.
- Fights took about 30 s on v11 and about 35–55 s on v12 (more reading and planning), not 90 s.
  Runs took 61–232 s.
- A dominant opener emerged: Greater Ignite + Ember Swing kills a 15-HP Hellhound before it acts,
  because Ignite burns at the start of the hound's turn.
- Block cards (Guard ×4, Brace) mostly went unplayed: Hellhound attacks were 1–2 damage and their
  real damage was unblockable Ignite.
- Spark (+1 energy, Fade) was left unplayed in about 9 of 23 v12 turns; Sniff was played 4 times.
- Card picks favoured Ignite: Ember Swing 9 times, Greater Ignite 3, out of 14 picks.
- Input: 5 cancelled drags in 7 runs (one in the gap between two hound panels, since widened);
  one likely accidental End turn (ended 0.3 s into the turn with 4 energy and a full hand).

**Owner, in their words (debrief 2026-10-31):**
- Hypothesis: "partially confirmed, fragment fired but I didn't plan around it. It was hard to see
  intents and keep around the companion bar because of the small sub-screen."
- Best moment: "There was no specific moment that clicks due to lack of content, but it feels like
  the game is coming around."
- Worst moment: "The third fight's opening burn killing me before I could act was pretty much it.
  If I cannot kill the 8 ignite hellhound on turn one I'm toast."
- Surprise: "Nothing really surprised me, it played as expected."
- Overall: "a pretty working game except for the difficulties reading, not very different from
  slay the spire due to all of our defining features being out of scope."
- Also: the fragment feels weak ("I somehow assumed he would be a stronger version"); Spark without
  a draw "finds very limited use"; Sniff "feels underwhelming"; Hellhounds should deal less Ignite.

**Changes attempted in response (not yet confirmed by play):**
- v12–v13 (readability): centred layout and full-screen button; drag hints (-X HP, BLOCKED, KILLS,
  FRAGMENT FIRES); the fragment panel brightens with charge and flickers when the next attack fires
  it; short intents; an enemy-turn forecast on the hero ("-16 (2 hit, 14 burn), next turn HP 15",
  matched the real result on 1,028 simulated turns); next-turn HP on each Hellhound. The owner played
  v12 (3 runs) and called it "much better now visually"; v13 has no logs yet.
- v14 (balance): Hellhound damage moved from Ignite to attacks so block matters; Spark draws 1;
  Sniff draws 2. Played by the owner for 2 runs (early evidence, below).

**v14 play log (2 runs, 2026-10-31).** The owner: "I felt more in control."
- Both runs cleared the region, with 24 and 7 HP left. Fights took 29–117 s.
- Block mattered: in one fight three Guards fully blocked both Hellhounds' attacks ("0 through block").
  Damage taken came mostly from hits; burn ticks were 1–7 (9–21 before).
- The 3-hound fight was no longer decided on turn 1 but stayed dangerous (one run took 10 through
  block on turn 1 and ended on 7 HP).
- Spark and Sniff were played in almost every fight; in one turn their draw allowed 6 plays and the
  fragment fired twice (three times that fight).
- Greater Ignite still opened 3 of 6 fights, in the 3-hound fight aimed at the strongest hound.
- Guard and Brace were played in only 3 of 6 fights (5 cards in 15 turns) and were left in hand on
  most turns. When played they worked; when skipped, the 3-hound fight cost 16 and 29 HP. Five
  defensive cards may be too many in a deck where killing fast is the best defence.
- Once, the fragment unleashed after the last Hellhound had died (wasted, harmless).

**Across all 9 runs (all three builds):**
- Card picks: Ember Swing 12 of 18, Greater Ignite 4, Swing 1, Brace 1. Guard and Heavy Swing were
  never picked. Cheap Ignite is the deck's favourite card throughout.
- Fragment unleashes per fight: 1.3 on v11, 1.1 on v12, 1.7 on v14. Twice in one turn only once (v14).
- Greater Ignite was the first card played in 5 of 12 fights on v11, 4 of 9 on v12 and 2 of 6 on v14.
- Spreading attacks across all three hounds right before an all-enemy unleash happened twice (v12
  run 1 and v14 run B, fight 3, turn 1). Possible priming, but the log cannot show intent.
- Deaths: 5, all on v11–v12, all in the 3-hound fight, all to burn (11–21 per tick).

---

## Metrics

| Metric | Value |
|--------|-------|
| Path used | Engine (Godot 4.7.2, web export) |
| Iterations to playable | First build was playable on desktop; readable on a phone only from v12, after the first playtest; 14 published builds in total |
| Prototype duration | 2 days (2026-10-30 to 2026-10-31) |
| Playtesters | 1 internal (the owner), 9 logged runs (4 on v11, 3 on v12, 2 on v14); 0 external |
| Feel assessment | Fights 30–55 s; reading intents and fragment state was the main friction on a phone until v12–v13; no moment "clicked" |
| Hypothesis verdict | PARTIALLY CONFIRMED: the loop only; the hook (fragment priming) untested. Winnable and losable: yes (owner cleared 2 of 7). About 90 s per fight: no (30–55 s). Wanting another fight: no evidence ("no specific moment that clicks") |

**Automatic battles (simple scripted players, not humans; 1,000 runs each).** "Sensible" blocks only
against attacks and focuses the weakest hound; "careless" plays random cards. Spirit rewards exist only
in this script.

| Build | Player | Pair: win / HP left | Three hounds: win | Region, card picks only | Region, picks + spirits |
|---|---|---|---|---|---|
| v11–v13 | sensible | 100% / 28.5 | 56% | 29% survive | 81% |
| v11–v13 | careless | 54% / 16.8 | 4.5% | 0% | 1.7% |
| v14 | sensible | 100% / 32.5 | 98% | 74% survive | 98% |
| v14 | careless | 73% / 21.1 | 21% | 1.6% | 16.7% |

---

## Recommendation: PROCEED

The core loop works: fights are short and both winnable and losable (the owner cleared 2 of 7 runs).
The owner's verdict is "Proceed, it's coming around and worth designing properly." Two weaknesses
showed up in play: the 3-hound opening burn, which made deaths depend on drawing one opener, and
reading intents and fragment state on a phone. v12–v14 attempt both fixes. Early evidence from 2 runs
on v14 is positive (both cleared, block mattered), but two runs are not enough to call either fixed. The concept's hook, fragment priming, is untested, and the combat does not yet feel distinct from
Slay the Spire because the features meant to set Bonefire apart were out of scope. PROCEED is
recommended on the condition that the next prototype targets the hook.

**Creative-director review (CD-PLAYTEST, 2026-10-31): CONCERNS. Owner accepted PROCEED with the concerns noted.**
The loop works; the core fantasy and the unique hook are not yet tested. Pillars: "tactical, not
luck-driven" was contradicted on v11–v12 (every death depended on the turn-1 opener); "spirits as
partners" barely present (one weak fragment, no chains possible); "a story you earn" and "fair to
players" out of M1 scope. Concerns and what resolves them:
1. Priming is unproven: a build where the owner's logs show card order changed to fire the fragment,
   and the owner says so.
2. Nothing yet distinguishes the game from Slay the Spire: one differentiator in the next build (a
   second fragment so chains are possible, or one memory card).
3. Luck-driven deaths: v14 play logs where deaths have more than one cause, block is played and no
   single opener dominates.
4. The fragment as a partner: the fragments GDD defines partner (agency, presence, payoff), not just
   more damage.
5. Tuning has drifted from the concept (draw 6, 30–55 s fights, region length): the design-doc update
   restates the region pacing target.

---

## If Proceeding

- **Core tuning values discovered:**
  - Hero: 40 HP, 4 energy, draw 6, block carry cap 3; 12-card starting deck.
  - Ember fragment: fires every 3 attacks, all enemies get 3 Ignite + Weak 1.
  - Hellhound (v14): 15 HP; ATK 4 + 1 Ignite + Weak 2 → ATK 5 + 1 Ignite + 6 block → ATK 6 + 4 Ignite.
  - Fights of up to 3 enemies; 2, 2, 3 per region; 10% max-HP heal between fights.
  - Fight length is about 30–55 s, so a region of 7 encounters is shorter than the 8–12 minutes planned.
- **Assumptions confirmed:** a three-fight run with visible intent and fixed energy is winnable and
  losable by a human player (2 of 7 cleared).
- **Early evidence (2 runs on v14):** block matters against v14 Hellhounds; Spark and Sniff get played
  once they draw; more draw lets the fragment fire more than once a turn.
- **Not yet shown (needs play evidence):** that intents and fragment state read well after v12–v13
  (beyond "much better now visually"); that card picks matter less than spirits (automatic battles only).
- **Assumptions disproved:** a 90 s battle (it is 30–55 s); Ignite as an enemy's main damage (it made
  block useless and the 3-hound fight depend on the turn-1 opener); the basic Ember fragment as an
  exciting companion.
- **Emergent mechanics:** Ignite ticking before the target acts makes it kill-before-acting damage,
  stronger than its listed number; the enemy-turn forecast became essential to play.

**Next steps:**
1. A few more v14 runs, to confirm the balance change beyond 2 runs (CD concern 3: so far block
   matters and no deaths; Greater Ignite still opens half the fights).
2. Next prototype targets the hook: add one differentiator (a second fragment so chains are possible,
   or a memory card) and look for logged priming decisions (CD concerns 1 and 2).
3. Bring the design doc's Content and Systems tabs in line with these numbers and restate the region
   pacing target (CD concern 5).
4. `/setup-engine godot 4.7.2` (the repo's engine setting is still empty).
5. `/design-review design/gdd/game-concept.md`, then `/gate-check`.
6. `/map-systems`, then `/design-system` for combat, fragments and enemies, using these tuning values;
   the fragments GDD defines what makes a spirit a partner (CD concern 4).

---

## If Pivoting

Not applicable: the verdict is PROCEED.

---

## If Killing

Not applicable: the verdict is PROCEED.

---

## Lessons Learned

- **What assumptions were broken by actually building this?**
  Fight length (half or a third of what was planned); Ignite as enemy damage; how much a phone
  screen hides. The first readable build came after the first playtest, not before.

- **What surprised us that didn't show up in the brainstorm?**
  Ignite ticking before the target acts made it the strongest effect for both sides; the free demo
  region was far harder than intended (v14 attempts a fix, unplayed so far).

- **What would we test differently next time?**
  Test on the target device from the first build; add the play log and forecast from the start;
  put one differentiating feature (a second fragment, or a memory card) into the first prototype so
  the "not different from Slay the Spire" question can be answered.

---

## Appendix: every logged run

Fights are 2, 2, then 3 Hellhounds. Each cell: result, turns, seconds, HP before → after, fragment
unleashes. Picks are the cards taken after fights 1 and 2. * = the owner was away from the screen at
the start, so the time is inflated.

| Build | Run | Fight 1 | Fight 2 | Fight 3 | Picks | End |
|---|---|---|---|---|---|---|
| v11 | 1 | won, 2 t, 22 s, 40 → 37, 1 | won, 4 t, 72 s, 40 → 5, 2 | lost, 2 t, from 9 HP (burn 11), 0 | Ember Swing, Swing | died in fight 3 |
| v11 | 2 | won, 2 t, 38 s, 40 → 37, 1 | won, 3 t, 26 s, 40 → 28, 1 | won, 3 t, 36 s, 32 → 13, 2 | Greater Ignite, Ember Swing | cleared |
| v11 | 3 | won, 4 t, 24 s, 40 → 21, 2 (likely accidental End turn) | won, 3 t, 17 s, 25 → 13, 2 | lost, 3 t, from 17 HP (burn 11, 16), 1 | Ember Swing, Ember Swing | died in fight 3 |
| v11 | 4 | won, 3 t, 22 s, 40 → 28, 2 | won, 3 t, 29 s, 32 → 18, 1 | lost, 3 t, from 22 HP (burn 11, 16), 1 | Brace, Ember Swing | died in fight 3 |
| v12 | 1 | won, 3 t, 74 s*, 40 → 26, 1 | won, 2 t, 55 s, 30 → 27, 1 | lost, 3 t, from 31 HP (burn 14, 21), 1 | Ember Swing, Ember Swing | died in fight 3 |
| v12 | 2 | won, 3 t, 58 s, 40 → 33, 1 | won, 2 t, 38 s, 37 → 34, 1 | won, 3 t, 54 s, 38 → 18, 2 | Greater Ignite, Ember Swing | cleared |
| v12 | 3 | won, 3 t, 166 s*, 40 → 20, 2 | won, 3 t, 34 s, 24 → 10, 1 | lost, 2 t, from 14 HP (burn 14), 0 | Greater Ignite, Ember Swing | died in fight 3 |
| v14 | A | won, 2 t, 56 s, 40 → 34, 1 | won, 2 t, 40 s, 38 → 37, 1 | won, 3 t, 87 s, 40 → 24, 3 | Ember Swing, Ember Swing | cleared |
| v14 | B | won, 2 t, 29 s, 40 → 39, 1 | won, 3 t, 117 s, 40 → 32, 2 | won, 3 t, 30 s, 36 → 7, 2 | Ember Swing, Greater Ignite | cleared |

---

> *Prototype code location: `prototypes/m1-combat-concept/`*
> *This code is throwaway. Never refactor into production.*
