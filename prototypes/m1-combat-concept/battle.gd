# PROTOTYPE - NOT FOR PRODUCTION
# Question: does ordering cards to prime the Ember fragment against two Hellhounds with visible intent create real decisions, in ~90 s per battle?
# Date: 2026-10-30
extends RefCounted

const CARDS := {
	"swing": {"name": "Swing", "cost": 1, "type": "attack", "dmg": 5, "desc": "Deal 5 damage"},
	"heavy": {"name": "Heavy Swing", "cost": 2, "type": "attack", "dmg": 12, "desc": "Deal 12 damage"},
	"ember_swing": {"name": "Ember Swing", "cost": 1, "type": "attack", "dmg": 2, "ignite": 3, "desc": "Deal 2 damage\nApply 3 Ignite"},
	"guard": {"name": "Guard", "cost": 1, "type": "skill", "block": 5, "desc": "Gain 5 block"},
	"brace": {"name": "Brace", "cost": 1, "type": "skill", "block": 6, "desc": "Gain 6 block"},
	"greater": {"name": "Greater Ignite", "cost": 3, "type": "attack", "dmg": 3, "ignite": 8, "desc": "Deal 3 damage\nApply 8 Ignite"},
	"sniff": {"name": "Sniff", "cost": 0, "type": "skill", "desc": "Draw 2\nSee intent 2 turns ahead"},
	"spark": {"name": "Spark", "cost": 0, "type": "skill", "desc": "Gain 1 energy\nDraw 1\nFade"},
}
const DECK := ["swing", "swing", "heavy", "ember_swing", "greater", "guard", "guard", "guard", "guard", "brace", "sniff", "spark"]
# Hellhound intents cycle in this order; hound k starts k steps in.
const INTENTS := [
	{"text": "Attack 4, apply 1 Ignite + Weak 2", "attack": 4, "block": 0, "weak": 2, "ignite": 1},
	{"text": "Attack 5, apply 1 Ignite, gain 6 block", "attack": 5, "block": 6, "weak": 0, "ignite": 1},
	{"text": "Attack 6, apply 4 Ignite", "attack": 6, "block": 0, "weak": 0, "ignite": 4},
]
const HOUNDS := 2
const HOUND_HP := 15
const ENERGY := 4
const DRAW := 6
const BLOCK_CAP := 3
const CHARGE_MAX := 3

var rng := RandomNumberGenerator.new()
var hero := {}
var foes: Array = []  # {name, hp, max, block, weak, ignite, i}
var energy := 0
var draw_pile: Array = []
var hand: Array = []
var discard: Array = []
var faded: Array = []
var charge := 0
var turn := 0
var sniffed_turn := -1
var unleashes := 0
var result := ""  # "", "won", "lost"
var log_lines: Array = []
# Run perks from rewards (sim only for now): ember_plus = extra Ignite on unleash,
# tide = Tide fragment (charges on gaining block, heals 4 at 3), kindle = Ignite per attack.
var perks := {}
var tide_charge := 0


func start(seed_value: int, hounds: int = HOUNDS, deck: Array = DECK, run_perks: Dictionary = {}) -> void:
	rng.seed = seed_value
	perks = run_perks
	tide_charge = 0
	hero = {"hp": 40, "max": 40, "block": 0, "weak": 0, "ignite": 0}
	foes = []
	for k in hounds:
		foes.append({"name": "Hellhound %d" % (k + 1), "hp": HOUND_HP, "max": HOUND_HP,
			"block": 0, "weak": 0, "ignite": 0, "i": k % INTENTS.size()})
	draw_pile = deck.duplicate()
	_shuffle(draw_pile)
	hand = []
	discard = []
	faded = []
	charge = 0
	turn = 0
	unleashes = 0
	result = ""
	log_lines = []
	_start_hero_turn()


func alive() -> Array:
	return foes.filter(func(f): return f.hp > 0)


func intent(f: Dictionary) -> Dictionary:
	return INTENTS[f.i]


func intent_after_next(f: Dictionary) -> Dictionary:
	return INTENTS[(f.i + 1) % INTENTS.size()]


func can_play(i: int) -> bool:
	return result == "" and i >= 0 and i < hand.size() and CARDS[hand[i]].cost <= energy


# target: the enemy an attack was dropped on (ignored for skills).
func play(i: int, target: Dictionary = {}) -> void:
	if not can_play(i):
		return
	var id: String = hand[i]
	var c: Dictionary = CARDS[id]
	if c.type == "attack" and (target.is_empty() or target.hp <= 0):
		return
	energy -= c.cost
	hand.remove_at(i)
	_log("You play %s" % c.name + (" on %s" % target.name if c.type == "attack" else ""))
	if c.has("dmg"):
		_hit(target, c.dmg)
	if c.has("ignite"):
		target.ignite += c.ignite
	if c.has("block"):
		_gain_block(c.block)
	match id:
		"sniff":
			_draw(2)
			sniffed_turn = turn
		"spark":
			energy += 1
			_draw(1)
	if id == "spark":
		faded.append(id)
	else:
		discard.append(id)
	if c.type == "attack" and perks.get("kindle", 0) > 0 and target.hp > 0:
		target.ignite += perks.kindle
	if c.type == "attack":
		charge += 1
		if charge >= CHARGE_MAX:
			charge = 0
			unleashes += 1
			for f in alive():
				f.ignite += 3 + perks.get("ember_plus", 0)
				f.weak += 1
			_log("EMBER FRAGMENT UNLEASHES: 3 Ignite + Weak 1 on all enemies")
	_check_end()


# What playing hand card i on target would do, without doing it (for the drag hint).
func preview(i: int, target: Dictionary = {}) -> Dictionary:
	var c: Dictionary = CARDS[hand[i]]
	var out := {"fires": c.type == "attack" and charge + 1 >= CHARGE_MAX}
	if c.has("dmg") and not target.is_empty():
		var dmg: int = c.dmg
		if hero.weak > 0:
			dmg = int(floor(dmg * 0.75))
		out.blocked = mini(target.block, dmg)
		out.through = dmg - out.blocked
		out.kills = target.hp - out.through <= 0
	if c.has("ignite"):
		out.ignite = c.ignite
	if c.has("block"):
		out.block = c.block
	return out


# What the enemy turn will do to you if you end the turn now, in turn order: each enemy burns first
# and only acts if it survives; its attack hits your current block. Returns hit, burn and your HP after.
func forecast() -> Dictionary:
	var block: int = hero.block
	var hit := 0
	var burn: int = hero.ignite
	for f in alive():
		if f.hp - f.ignite <= 0:
			continue
		var it: Dictionary = intent(f)
		var dmg: int = int(floor(it.attack * 0.75)) if f.weak > 0 else it.attack
		var blocked := mini(block, dmg)
		block -= blocked
		hit += dmg - blocked
		burn += it.ignite
	return {"hit": hit, "burn": burn, "hp_next": hero.hp - hit - burn}


func end_turn() -> void:
	if result != "":
		return
	discard.append_array(hand)
	hand = []
	if hero.weak > 0:
		hero.weak -= 1
	for f in foes:
		if f.hp > 0 and result == "":
			_foe_turn(f)
	if result == "":
		_start_hero_turn()


func _gain_block(n: int) -> void:
	hero.block += n
	if perks.get("tide", false):
		tide_charge += 1
		if tide_charge >= 3:
			tide_charge = 0
			hero.hp = mini(hero.max, hero.hp + 4)
			_log("TIDE FRAGMENT UNLEASHES: heal 4")


func _start_hero_turn() -> void:
	turn += 1
	hero.block = mini(hero.block, BLOCK_CAP)
	_tick_ignite(hero, "You")
	if _check_end():
		return
	energy = ENERGY
	_draw(DRAW)


func _foe_turn(f: Dictionary) -> void:
	f.block = 0
	_tick_ignite(f, f.name)
	if f.hp <= 0:
		_log("%s is defeated" % f.name)
		_check_end()
		return
	var it: Dictionary = intent(f)
	if it.attack > 0:
		var dmg: int = it.attack
		if f.weak > 0:
			dmg = int(floor(dmg * 0.75))
		var taken := _absorb(hero, dmg)
		_log("%s attacks for %d (%d through block)" % [f.name, dmg, taken])
	if it.block > 0:
		f.block += it.block
	if it.weak > 0:
		hero.weak += it.weak
		_log("%s applies Weak %d to you" % [f.name, it.weak])
	if it.ignite > 0:
		hero.ignite += it.ignite
		_log("%s applies %d Ignite to you" % [f.name, it.ignite])
	if f.weak > 0:
		f.weak -= 1
	f.i = (f.i + 1) % INTENTS.size()
	_check_end()


func _hit(f: Dictionary, base: int) -> void:
	var dmg := base
	if hero.weak > 0:
		dmg = int(floor(base * 0.75))
	_absorb(f, dmg)
	if f.hp <= 0:
		_log("%s is defeated" % f.name)


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
	if alive().is_empty():
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
