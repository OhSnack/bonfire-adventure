# PROTOTYPE - NOT FOR PRODUCTION
# Question: can the M1 battle (two Hellhounds) be both won and lost, and how long does it take?
# Date: 2026-10-30
# Run: godot --headless --path . --script res://sim.gd
extends SceneTree

const Battle := preload("res://battle.gd")
const N := 1000
const HEAL := 4  # 10% of max HP between battles


func _init() -> void:
	for policy in ["careless", "greedy"]:
		var won := 0
		var turns := 0
		var unleashes := 0
		var hp_left := 0
		for s in N:
			var b = Battle.new()
			b.start(s)
			_run(b, policy, s)
			turns += b.turn
			unleashes += b.unleashes
			if b.result == "won":
				won += 1
				hp_left += b.hero.hp
		print("%-8s win %5.1f%%  avg turns %.1f  avg unleashes %.1f  avg HP left on wins %.1f" % [
			policy, 100.0 * won / N, float(turns) / N, float(unleashes) / N, float(hp_left) / maxi(won, 1)])
	# Three encounters in a row; HP carries over with HEAL between them.
	for policy in ["careless", "greedy"]:
		var survive := [0, 0, 0]
		var hp_after := [0, 0, 0]
		for s in N:
			var hp := 40
			for k in 3:
				var b = Battle.new()
				b.start(s * 7 + k)
				b.hero.hp = hp
				_run(b, policy, s * 7 + k)
				if b.result != "won":
					break
				survive[k] += 1
				hp_after[k] += b.hero.hp
				hp = mini(40, b.hero.hp + HEAL)
		print("%-8s 3 in a row: survive %5.1f%% %5.1f%% %5.1f%%  avg HP after each %.1f %.1f %.1f" % [policy,
			100.0 * survive[0] / N, 100.0 * survive[1] / N, 100.0 * survive[2] / N,
			float(hp_after[0]) / maxi(survive[0], 1), float(hp_after[1]) / maxi(survive[1], 1), float(hp_after[2]) / maxi(survive[2], 1)])
	quit()


func _run(b, policy: String, seed_value: int) -> void:
	var pick := RandomNumberGenerator.new()
	pick.seed = seed_value
	while b.result == "" and b.turn < 50:
		_play_turn(b, policy, pick)
		b.end_turn()


# careless: random affordable cards on random hounds, sometimes stops early.
# greedy: zero-cost first, blocks only against attacks, focuses the weakest hound.
func _play_turn(b, policy: String, pick: RandomNumberGenerator) -> void:
	while b.result == "":
		var playable: Array = []
		for i in b.hand.size():
			if b.can_play(i):
				playable.append(i)
		if playable.is_empty():
			return
		var foes: Array = b.alive()
		if policy == "careless":
			if pick.randf() < 0.15:
				return
			b.play(playable[pick.randi_range(0, playable.size() - 1)], foes[pick.randi_range(0, foes.size() - 1)])
			continue
		var target: Dictionary = foes[0]
		var incoming := 0
		for f in foes:
			incoming += b.intent(f).attack
			if f.hp < target.hp:
				target = f
		var best := -1
		var best_score := -1.0
		for i in playable:
			var score := 0.0
			match b.hand[i]:
				"spark", "sniff": score = 100
				"heavy": score = 12
				"greater": score = 11
				"swing": score = 5.5
				"ember_swing": score = 6
				"guard": score = 6 if b.hero.block < incoming else 0.5
				"brace": score = 5.5 if b.hero.block < incoming else 0.4
			if score > best_score:
				best_score = score
				best = i
		b.play(best, target)
