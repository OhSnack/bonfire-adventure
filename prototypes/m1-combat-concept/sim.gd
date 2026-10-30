# PROTOTYPE - NOT FOR PRODUCTION
# Question: can the M1 battle be both won and lost, and how many turns does it take?
# Date: 2026-10-30
# Run: godot --headless --path . --script res://sim.gd
extends SceneTree

const Battle := preload("res://battle.gd")
const N := 500


func _init() -> void:
	for policy in ["careless", "greedy"]:
		var won := 0
		var turns := 0
		var unleashes := 0
		var hp_left := 0
		for s in N:
			var b = Battle.new()
			b.start(s)
			var pick := RandomNumberGenerator.new()
			pick.seed = s
			while b.result == "" and b.turn < 50:
				_play_turn(b, policy, pick)
				b.end_turn()
			turns += b.turn
			unleashes += b.unleashes
			if b.result == "won":
				won += 1
				hp_left += b.hero.hp
		print("%-8s win %5.1f%%  avg turns %.1f  avg unleashes %.1f  avg HP left on wins %.1f" % [
			policy, 100.0 * won / N, float(turns) / N, float(unleashes) / N,
			float(hp_left) / maxi(won, 1)])
	quit()


# careless: plays random affordable cards, sometimes stops early.
# greedy: zero-cost first, blocks only against an attack, then highest-damage attacks.
func _play_turn(b, policy: String, pick: RandomNumberGenerator) -> void:
	while b.result == "":
		var playable: Array = []
		for i in b.hand.size():
			if b.can_play(i):
				playable.append(i)
		if playable.is_empty():
			return
		if policy == "careless":
			if pick.randf() < 0.15:
				return
			b.play(playable[pick.randi_range(0, playable.size() - 1)])
			continue
		var best := -1
		var best_score := -1.0
		var incoming: int = b.intent().attack
		for i in playable:
			var id: String = b.hand[i]
			var score := 0.0
			match id:
				"spark", "sniff": score = 100
				"heavy": score = 13
				"swing": score = 6.5
				"ember_swing": score = 7
				"guard": score = 6 if b.hero.block < incoming else 0.5
				"brace": score = 5 if b.hero.block < incoming else 0.4
			if score > best_score:
				best_score = score
				best = i
		b.play(best)
