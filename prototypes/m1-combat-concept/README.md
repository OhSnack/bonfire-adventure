<!-- PROTOTYPE - NOT FOR PRODUCTION -->
<!-- Question: does ordering stick-deck cards to prime the Ember fragment against a Shed with visible intent create real decisions, in ~90 s per battle? -->
<!-- Date: 2026-10-30 -->
# M1 combat concept prototype

**Status:** in progress

## Hypothesis
If the player orders the stick deck's cards to prime and fire the Ember fragment against
a Shed with visible intent, they will feel in tactical control. True if a battle ends in
about 90 seconds, smart play clearly beats careless play, and the player wants another battle.

Riskiest assumption: auto-unleash is readable and creates priming decisions at that pace.

## How to run
- **Desktop:** open this folder in Godot 4.7.2 and press Play (F5).
- **Browser:** the private Claude artifact https://claude.ai/artifact/6Lb5uPxvZKk2fNQktRD6zD, rebuilt with
  `web/build_web.sh` into `build/m1-web/` (publish `page.html` with `index.js` and `godot-engine-gzip.wasm`).
- **Play log:** the "Play log" button above the game collects every run played in that browser (turn
  snapshots, plays, misdrops, unplayed cards, enemy actions, rewards, timings) for copying into the chat.
- **Debug:** press W to win the current fight instantly (tests the reward and end screens).
- **Automatic battles:** `godot --headless --path . --script res://sim.gd`.

## Rules (numbers from the design doc's Content tab, with the owner's 2026-10-30 changes)
- Hero 40 HP, 4 energy, draw 6; block above 3 is lost at the start of your turn.
- Deck (12): Swing ×2 (5 dmg), Heavy Swing (12), Ember Swing (2 + 3 Ignite), Greater Ignite (3 energy: 3 + 8 Ignite),
  Guard ×4, Brace (1 energy: 6 block), Sniff, Spark.
  Attack damage is 1 lower than the Content tab (owner change, 2026-10-30).
- Enemies: two Hellhounds (skeletal dogs with fiery plumes; were the Shed), 15 HP each; the second starts
  one step later in the cycle. Intents cycle:
  attack 1 + 3 Ignite + Weak 2 → attack 2 + 3 Ignite + gain 6 block → apply 8 Ignite.
- Ember fragment: +1 charge per attack card; at 3 it fires mid-turn: 3 Ignite + Weak 1 on every enemy.
- Between battles (not in this one-battle build): the hero heals 10% of max HP (4).
- Drag attacks onto a Hellhound; drag skills above the line.
- Placeholders: the enemy's block resets each turn; Weak N lasts N of the target's turns
  (−25%, rounded down); Ignite ticks at the start of its target's turn, then halves;
  the discard pile reshuffles when the draw pile is empty.

## The run (playable)
Three fights: 2, 2, then 3 Hellhounds. HP carries over with a 4 HP heal after each fight.
After fights 1 and 2, pick 1 of 3 cards (from Greater Ignite, Heavy Swing, Ember Swing, Swing,
Brace, Guard) or skip.

## Region test (sim.gd)
Fights of 2, 2, then 3 Hellhounds (3 is the most per fight), +4 HP between fights. Placeholder
rewards after each fight: pick 1 of 3 starting cards, and one spirit (Tide fragment, Ember unleash
+2 Ignite, or the Kindle boon: attacks also apply 3 Ignite).

## Findings
In progress (debrief started 2026-10-31). From the owner's play log of 4 runs on v11:
- Cleared 1 of 4 runs; every death was Ignite burn in the 3-Hellhound fight.
- Fights took about 30 s (17-38 s, one 72 s), not the 90 s planned; runs 61-113 s.
- Dominant opener: Greater Ignite + Ember Swing kills a 15-HP hound before it acts, because
  Ignite burns at the start of the hound's turn.
- Block cards mostly went unplayed; Hellhound attacks are 1-2 damage.
- Hypothesis: partially confirmed. The fragment fired, but the owner did not plan around it: on a
  phone the game drew in a small part of the screen and intents were hard to read.
- Owner: "a pretty working game except for the difficulties reading, not very different from Slay
  the Spire", because the defining features (haven, memories, mantles, more fragments) are out of scope.
- v12 response: centred layout + full screen, drag hints (damage, blocked, kills, fragment fires),
  fragment glow and flicker when primed, short intents, burn warnings, wider drop zones.
