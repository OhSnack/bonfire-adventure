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
- **Browser:** the private Claude artifact built from `../../build/m1-web/`
  (`godot --headless --path . --export-release Web`).
- **Automatic battles:** `godot --headless --path . --script res://sim.gd`.

## Rules (numbers from the design doc's Content tab, with the owner's 2026-10-30 changes)
- Hero 40 HP, 4 energy, draw 5; block above 3 is lost at the start of your turn.
- Stick deck: Swing ×2, Heavy Swing, Ember Swing, Guard ×3, Brace, Sniff, Spark.
- Shed 45 HP, intents cycle: attack 4 + apply Weak 2 → attack 5 + gain 6 block → attack 3 + apply 8 Ignite.
- Ember fragment: +1 charge per attack card; at 4 it fires mid-turn: 3 Ignite + Weak 1 on the Shed.
- Drag attacks onto the Shed; drag skills above the line.
- Placeholders: the Shed's block resets each turn; Weak N lasts N of the target's turns
  (−25%, rounded down); Ignite ticks at the start of its target's turn, then halves;
  the discard pile reshuffles when the draw pile is empty.

## Findings
_Filled in at the debrief._
