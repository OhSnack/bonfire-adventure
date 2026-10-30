# PROTOTYPE - NOT FOR PRODUCTION
# Question: can a region of Hellhound packs (2, 2, then 3) be won and lost, with and without rewards between fights?
# Date: 2026-10-30
# Run: godot --headless --path . --script res://sim.gd
extends SceneTree

const Battle := preload("res://battle.gd")
const N := 1000
const HEAL := 4  # 10% of max HP between fights
const REGION := [2, 2, 3]  # hounds per fight
# Placeholder reward pool: the starting cards. Higher = picked first by the sensible player.
const POOL := {"greater": 6, "heavy": 5, "ember_swing": 4, "swing": 3, "brace": 2, "guard": 1}
# Spirit reward plans (one spirit after each fight): what each spirit gives, in order.
const PLANS := {
	"no rewards": [],
	"cards only": [],
	"cards + Tide, then Ember +2": [{"tide": true}, {"ember_plus": 2}],
	"cards + Ember +2 each": [{"ember_plus": 2}, {"ember_plus": 2}],
	"cards + Kindle 3, then Ember +2": [{"kindle": 3}, {"ember_plus": 2}],
}


func _init() -> void:
	for n in [2, 3]:
		for policy in ["careless", "greedy"]:
			var r := _single(policy, n)
			print("%d hounds, %-8s win %5.1f%%  turns %.1f  unleashes %.1f  HP left on wins %.1f" % [n, policy, r[0], r[1], r[2], r[3]])
	print("Region: fights of %s hounds, +%d HP between fights" % [str(REGION), HEAL])
	for plan in PLANS:
		for policy in ["careless", "greedy"]:
			var survive := [0, 0, 0]
			var hp_after := [0, 0, 0]
			for s in N:
				var hp := 40
				var deck: Array = Battle.DECK.duplicate()
				var perks := {}
				var rng := RandomNumberGenerator.new()
				rng.seed = s
				for k in REGION.size():
					var b = Battle.new()
					b.start(s * 7 + k, REGION[k], deck, perks)
					b.hero.hp = hp
					_run(b, policy, s * 7 + k)
					if b.result != "won":
						break
					survive[k] += 1
					hp_after[k] += b.hero.hp
					hp = mini(40, b.hero.hp + HEAL)
					if plan != "no rewards":
						_pick_card(deck, policy, rng)
					if k < PLANS[plan].size():
						perks = _merge(perks, PLANS[plan][k])
			print("  %-34s %-8s survive %5.1f%% %5.1f%% %5.1f%%  HP after each %4.1f %4.1f %4.1f" % [plan, policy,
				100.0 * survive[0] / N, 100.0 * survive[1] / N, 100.0 * survive[2] / N,
				float(hp_after[0]) / maxi(survive[0], 1), float(hp_after[1]) / maxi(survive[1], 1), float(hp_after[2]) / maxi(survive[2], 1)])
	quit()


func _single(policy: String, n: int) -> Array:
	var won := 0
	var turns := 0
	var unleashes := 0
	var hp_left := 0
	for s in N:
		var b = Battle.new()
		b.start(s, n)
		_run(b, policy, s)
		turns += b.turn
		unleashes += b.unleashes
		if b.result == "won":
			won += 1
			hp_left += b.hero.hp
	return [100.0 * won / N, float(turns) / N, float(unleashes) / N, float(hp_left) / maxi(won, 1)]


func _pick_card(deck: Array, policy: String, rng: RandomNumberGenerator) -> void:
	var ids: Array = POOL.keys()
	var offer: Array = []
	for k in 3:
		offer.append(ids[rng.randi_range(0, ids.size() - 1)])
	if policy == "careless":
		if rng.randf() < 0.25:
			return
		deck.append(offer[rng.randi_range(0, 2)])
		return
	var best: String = offer[0]
	for id in offer:
		if POOL[id] > POOL[best]:
			best = id
	deck.append(best)


func _merge(perks: Dictionary, gain: Dictionary) -> Dictionary:
	var out := perks.duplicate()
	for key in gain:
		if gain[key] is bool:
			out[key] = gain[key]
		else:
			out[key] = out.get(key, 0) + gain[key]
	return out


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
