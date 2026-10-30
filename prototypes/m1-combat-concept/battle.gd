# PROTOTYPE - NOT FOR PRODUCTION
# Question: does ordering stick-deck cards to prime the Ember fragment against a Shed with visible intent create real decisions, in ~90 s per battle?
# Date: 2026-10-30
extends RefCounted

const CARDS := {
	"swing": {"name": "Swing", "cost": 1, "type": "attack", "desc": "Deal 5 damage"},
	"heavy": {"name": "Heavy Swing", "cost": 2, "type": "attack", "desc": "Deal 12 damage"},
	"ember_swing": {"name": "Ember Swing", "cost": 1, "type": "attack", "desc": "Deal 2 damage\nApply 3 Ignite"},
	"guard": {"name": "Guard", "cost": 1, "type": "skill", "desc": "Gain 5 block"},
	"brace": {"name": "Brace", "cost": 1, "type": "skill", "desc": "Gain 6 block"},
	"greater": {"name": "Greater Ignite", "cost": 3, "type": "attack", "desc": "Deal 3 damage\nApply 8 Ignite"},
	"sniff": {"name": "Sniff", "cost": 0, "type": "skill", "desc": "Draw 1\nSee intent 2 turns ahead"},
	"spark": {"name": "Spark", "cost": 0, "type": "skill", "desc": "Gain 1 energy\nFade"},
}
const DECK := ["swing", "swing", "heavy", "ember_swing", "greater", "guard", "guard", "guard", "guard", "brace", "sniff", "spark"]
# Hellhound intents cycle in this order (the code still calls the enemy "shed").
const INTENTS := [
	{"text": "Attack 1, apply 3 Ignite + Weak 2", "attack": 1, "block": 0, "weak": 2, "ignite": 3},
	{"text": "Attack 2, apply 3 Ignite, gain 6 block", "attack": 2, "block": 6, "weak": 0, "ignite": 3},
	{"text": "Apply 8 Ignite", "attack": 0, "block": 0, "weak": 0, "ignite": 8},
]
const ENERGY := 4
const DRAW := 6
const BLOCK_CAP := 3
const CHARGE_MAX := 3

var rng := RandomNumberGenerator.new()
var hero := {}
var shed := {}
var energy := 0
var draw_pile: Array = []
var hand: Array = []
var discard: Array = []
var faded: Array = []
var charge := 0
var intent_i := 0
var turn := 0
var sniffed_turn := -1
var unleashes := 0
var result := ""  # "", "won", "lost"
var log_lines: Array = []


func start(seed_value: int) -> void:
	rng.seed = seed_value
	hero = {"hp": 40, "max": 40, "block": 0, "weak": 0, "ignite": 0}
	shed = {"hp": 30, "max": 30, "block": 0, "weak": 0, "ignite": 0}
	draw_pile = DECK.duplicate()
	_shuffle(draw_pile)
	hand = []
	discard = []
	faded = []
	charge = 0
	intent_i = 0
	turn = 0
	unleashes = 0
	result = ""
	log_lines = []
	_start_hero_turn()


func intent() -> Dictionary:
	return INTENTS[intent_i]


func intent_after_next() -> Dictionary:
	return INTENTS[(intent_i + 1) % INTENTS.size()]


func can_play(i: int) -> bool:
	return result == "" and i >= 0 and i < hand.size() and CARDS[hand[i]].cost <= energy


func play(i: int) -> void:
	if not can_play(i):
		return
	var id: String = hand[i]
	var c: Dictionary = CARDS[id]
	energy -= c.cost
	hand.remove_at(i)
	match id:
		"swing": _hit_shed(5)
		"heavy": _hit_shed(12)
		"ember_swing":
			_hit_shed(2)
			shed.ignite += 3
		"guard": hero.block += 5
		"brace": hero.block += 6
		"greater":
			_hit_shed(3)
			shed.ignite += 8
		"sniff":
			_draw(1)
			sniffed_turn = turn
		"spark": energy += 1
	_log("You play %s" % c.name)
	if id == "spark":
		faded.append(id)
	else:
		discard.append(id)
	if c.type == "attack":
		charge += 1
		if charge >= CHARGE_MAX:
			charge = 0
			unleashes += 1
			# Hits every enemy; the prototype has one.
			shed.ignite += 3
			shed.weak += 1
			_log("EMBER FRAGMENT UNLEASHES: 3 Ignite + Weak 1 on all enemies")
	_check_end()


func end_turn() -> void:
	if result != "":
		return
	discard.append_array(hand)
	hand = []
	if hero.weak > 0:
		hero.weak -= 1
	_shed_turn()
	if result == "":
		_start_hero_turn()


func _start_hero_turn() -> void:
	turn += 1
	hero.block = mini(hero.block, BLOCK_CAP)
	_tick_ignite(hero, "You")
	if _check_end():
		return
	energy = ENERGY
	_draw(DRAW)


func _shed_turn() -> void:
	shed.block = 0
	_tick_ignite(shed, "The Hellhound")
	if _check_end():
		return
	var it: Dictionary = intent()
	if it.attack > 0:
		var dmg: int = it.attack
		if shed.weak > 0:
			dmg = int(floor(dmg * 0.75))
		var taken := _absorb(hero, dmg)
		_log("Hellhound attacks for %d (%d through block)" % [dmg, taken])
	if it.block > 0:
		shed.block += it.block
	if it.weak > 0:
		hero.weak += it.weak
		_log("Hellhound applies Weak %d to you" % it.weak)
	if it.ignite > 0:
		hero.ignite += it.ignite
		_log("Hellhound applies %d Ignite to you" % it.ignite)
	if shed.weak > 0:
		shed.weak -= 1
	intent_i = (intent_i + 1) % INTENTS.size()
	_check_end()


func _hit_shed(base: int) -> void:
	var dmg := base
	if hero.weak > 0:
		dmg = int(floor(base * 0.75))
	_absorb(shed, dmg)


# Returns the damage that got through block.
func _absorb(target: Dictionary, dmg: int) -> int:
	var blocked := mini(target.block, dmg)
	target.block -= blocked
	target.hp -= dmg - blocked
	return dmg - blocked


func _tick_ignite(target: Dictionary, who: String) -> void:
	if target.ignite <= 0:
		return
	target.hp -= target.ignite
	_log("%s burn for %d (Ignite)" % [who, target.ignite])
	target.ignite = target.ignite / 2


func _draw(n: int) -> void:
	for k in n:
		if draw_pile.is_empty():
			if discard.is_empty():
				return
			draw_pile = discard
			discard = []
			_shuffle(draw_pile)
		hand.append(draw_pile.pop_back())


func _check_end() -> bool:
	if shed.hp <= 0:
		result = "won"
	elif hero.hp <= 0:
		result = "lost"
	return result != ""


func _shuffle(a: Array) -> void:
	for k in range(a.size() - 1, 0, -1):
		var j := rng.randi_range(0, k)
		var t = a[k]
		a[k] = a[j]
		a[j] = t


func _log(s: String) -> void:
	log_lines.append(s)
