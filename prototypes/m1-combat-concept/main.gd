# PROTOTYPE - NOT FOR PRODUCTION
# Question: does a 3-fight run against Hellhound packs, with a card pick between fights, create real decisions in ~90 s per fight?
# Date: 2026-10-30
extends Control

const Battle := preload("res://battle.gd")
const CARD_SIZE := Vector2(140, 200)
const HAND_Y := 500.0
const PLAY_LINE_Y := 450.0
const REGION := [2, 2, 3]  # hounds per fight; 3 is the most a fight can have
const HEAL := 4  # 10% of max HP after each fight
const REWARD_POOL := ["greater", "heavy", "ember_swing", "swing", "brace", "guard"]
const MAX_FOES := 3

var b = Battle.new()
var fight := 0
var run_deck: Array = []
var run_time := 0.0
var fight_time := 0.0
var cards: Array = []  # Panel per hand card
var drag_i := -1
var drag_offset := Vector2.ZERO
var foe_panels: Array = []
var foe_labels: Array = []
var intent_labels: Array = []
var hero_label: Label
var frag_panel: Panel
var frag_label: Label
var status_label: Label
var energy_label: Label
var log_label: Label
var piles_label: Label
var end_btn: Button
var end_box: Panel
var end_label: Label
var reward_box: Panel
var reward_label: Label
var reward_buttons: Array = []
var reward_offer: Array = []
var hint_line: ColorRect


func _ready() -> void:
	var bg := ColorRect.new()
	bg.color = Color("1b1622")
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)
	status_label = _label(Vector2(20, 12), 22)
	var hero_panel := _panel(Vector2(30, 110), Vector2(230, 200), Color("2e4a3a"))
	hero_label = _wrapped(_label(Vector2(12, 10), 19, hero_panel), Vector2(206, 184))
	frag_panel = _panel(Vector2(275, 120), Vector2(265, 150), Color("4a3a1e"))
	frag_label = _wrapped(_label(Vector2(12, 10), 18, frag_panel), Vector2(241, 130))
	for k in MAX_FOES:
		var x := 560.0 + k * 235.0
		var p := _panel(Vector2(x, 110), Vector2(220, 200), Color("5a2e2e"))
		foe_panels.append(p)
		foe_labels.append(_wrapped(_label(Vector2(12, 10), 18, p), Vector2(196, 184)))
		var il := _wrapped(_label(Vector2(x, 34), 15), Vector2(220, 74))
		il.add_theme_color_override("font_color", Color("ffd27a"))
		intent_labels.append(il)
	log_label = _label(Vector2(275, 322), 15)
	log_label.add_theme_color_override("font_color", Color("c9c2d6"))
	hint_line = ColorRect.new()
	hint_line.color = Color(1, 1, 1, 0.12)
	hint_line.position = Vector2(0, PLAY_LINE_Y)
	hint_line.size = Vector2(1280, 2)
	add_child(hint_line)
	var hint := _label(Vector2(20, PLAY_LINE_Y - 26), 15)
	hint.text = "Drag attacks onto a Hellhound · drag skills above this line"
	hint.add_theme_color_override("font_color", Color(1, 1, 1, 0.4))
	energy_label = _label(Vector2(1110, 515), 26)
	piles_label = _label(Vector2(20, 462), 15)
	end_btn = Button.new()
	end_btn.text = "End turn"
	end_btn.position = Vector2(1110, 600)
	end_btn.size = Vector2(150, 70)
	end_btn.add_theme_font_size_override("font_size", 22)
	end_btn.pressed.connect(_on_end_turn)
	add_child(end_btn)
	_build_reward_box()
	end_box = _panel(Vector2(400, 220), Vector2(480, 220), Color("101018"))
	end_label = _wrapped(_label(Vector2(20, 20), 22, end_box), Vector2(440, 120))
	var again := Button.new()
	again.text = "New run"
	again.position = Vector2(160, 150)
	again.size = Vector2(160, 50)
	again.pressed.connect(_new_run)
	end_box.add_child(again)
	_new_run()


func _build_reward_box() -> void:
	reward_box = _panel(Vector2(250, 90), Vector2(780, 400), Color("101018"))
	reward_label = _wrapped(_label(Vector2(24, 18), 22, reward_box), Vector2(732, 70))
	for k in 3:
		var btn := Button.new()
		btn.position = Vector2(24 + k * 250, 110)
		btn.size = Vector2(230, 200)
		btn.add_theme_font_size_override("font_size", 18)
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD
		btn.pressed.connect(_on_pick.bind(k))
		reward_box.add_child(btn)
		reward_buttons.append(btn)
	var skip := Button.new()
	skip.text = "Skip"
	skip.position = Vector2(315, 330)
	skip.size = Vector2(150, 50)
	skip.pressed.connect(_on_pick.bind(-1))
	reward_box.add_child(skip)


func _new_run() -> void:
	fight = 0
	run_deck = Battle.DECK.duplicate()
	run_time = 0.0
	_start_fight(40)


func _start_fight(hp: int) -> void:
	b.start(randi(), REGION[fight], run_deck)
	b.hero.hp = hp
	fight_time = 0.0
	end_box.visible = false
	reward_box.visible = false
	_refresh()


func _process(delta: float) -> void:
	if b.result == "":
		fight_time += delta
		run_time += delta
	status_label.text = "Fight %d of %d · Turn %d    %d:%02d" % [fight + 1, REGION.size(), b.turn, int(fight_time) / 60, int(fight_time) % 60]


func _input(event: InputEvent) -> void:
	if b.result != "":
		return
	# Debug: W wins the current fight, to test the reward and end screens quickly.
	if event is InputEventKey and event.pressed and event.keycode == KEY_W:
		for f in b.foes:
			f.hp = 0
		b._check_end()
		_refresh()
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for i in range(cards.size() - 1, -1, -1):
				if cards[i].get_global_rect().has_point(event.position):
					drag_i = i
					drag_offset = event.position - cards[i].position
					cards[i].move_to_front()
					break
		elif drag_i >= 0:
			_drop(event.position)
	elif event is InputEventMouseMotion and drag_i >= 0:
		cards[drag_i].position = event.position - drag_offset
		var attack: bool = Battle.CARDS[b.hand[drag_i]].type == "attack"
		var over := _foe_at(event.position)
		for k in b.foes.size():
			foe_panels[k].modulate = Color(1.4, 1.3, 0.8) if attack and k == over else _foe_tint(k)
		var on_line: bool = not attack and event.position.y < PLAY_LINE_Y
		hint_line.color = Color(1, 1, 0.5, 0.6) if on_line else Color(1, 1, 1, 0.12)


# Index of the living enemy under pos, or -1.
func _foe_at(pos: Vector2) -> int:
	for k in b.foes.size():
		if b.foes[k].hp > 0 and foe_panels[k].get_global_rect().has_point(pos):
			return k
	return -1


func _foe_tint(k: int) -> Color:
	return Color(0.4, 0.4, 0.4) if b.foes[k].hp <= 0 else Color.WHITE


func _drop(pos: Vector2) -> void:
	var i := drag_i
	drag_i = -1
	hint_line.color = Color(1, 1, 1, 0.12)
	var attack: bool = Battle.CARDS[b.hand[i]].type == "attack"
	var over := _foe_at(pos)
	var unleashes_before: int = b.unleashes
	if attack and over >= 0:
		b.play(i, b.foes[over])
	elif not attack and pos.y < PLAY_LINE_Y:
		b.play(i)
	if b.unleashes > unleashes_before:
		_flash(frag_panel)
	_refresh()


func _on_end_turn() -> void:
	b.end_turn()
	_refresh()


func _on_fight_over() -> void:
	var summary := "Fight %d %s in %d turns, %d s." % [fight + 1, "won" if b.result == "won" else "lost", b.turn, int(fight_time)]
	print("RESULT ", summary, " HP ", b.hero.hp)
	if b.result == "lost":
		_show_end("Defeated in fight %d of %d.\n%s\nRun time %d s." % [fight + 1, REGION.size(), summary, int(run_time)])
	elif fight == REGION.size() - 1:
		_show_end("Region cleared with %d / %d HP.\n%s\nRun time %d s · deck %d cards." % [b.hero.hp, b.hero.max, summary, int(run_time), run_deck.size()])
	else:
		_show_reward(summary)


func _show_end(text: String) -> void:
	end_label.text = text
	end_box.visible = true
	end_box.move_to_front()


func _show_reward(summary: String) -> void:
	var healed: int = mini(b.hero.max, b.hero.hp + HEAL)
	reward_label.text = "%s You heal %d (HP %d / %d).\nPick a card to add to your deck (%d cards), or skip." % [
		summary, healed - b.hero.hp, healed, b.hero.max, run_deck.size()]
	var pool: Array = REWARD_POOL.duplicate()
	pool.shuffle()
	reward_offer = pool.slice(0, 3)
	for k in 3:
		var c: Dictionary = Battle.CARDS[reward_offer[k]]
		reward_buttons[k].text = "(%d) %s\n\n%s" % [c.cost, c.name, c.desc]
	reward_box.visible = true
	reward_box.move_to_front()


func _on_pick(k: int) -> void:
	if k >= 0:
		run_deck.append(reward_offer[k])
	var hp: int = mini(b.hero.max, b.hero.hp + HEAL)
	fight += 1
	_start_fight(hp)


func _refresh() -> void:
	hero_label.text = "YOU\nHP %d / %d\nBlock %d%s%s" % [b.hero.hp, b.hero.max, b.hero.block,
		"\nWeak %d (-25%% damage)" % b.hero.weak if b.hero.weak > 0 else "",
		"\nIgnite %d" % b.hero.ignite if b.hero.ignite > 0 else ""]
	for k in MAX_FOES:
		var shown: bool = k < b.foes.size()
		foe_panels[k].visible = shown
		intent_labels[k].visible = shown
		if not shown:
			continue
		var f: Dictionary = b.foes[k]
		foe_panels[k].modulate = _foe_tint(k)
		if f.hp <= 0:
			foe_labels[k].text = "%s\nDefeated" % f.name.to_upper()
			intent_labels[k].text = ""
			continue
		foe_labels[k].text = "%s\nHP %d / %d\nBlock %d%s%s" % [f.name.to_upper(), f.hp, f.max, f.block,
			"\nWeak %d" % f.weak if f.weak > 0 else "",
			"\nIgnite %d (burns at its turn)" % f.ignite if f.ignite > 0 else ""]
		var it: Dictionary = b.intent(f)
		var t: String = it.text
		if f.weak > 0 and it.attack > 0:
			t += " (Weak: %d)" % int(floor(it.attack * 0.75))
		intent_labels[k].text = "Intent: " + t
		if b.sniffed_turn == b.turn:
			intent_labels[k].text += "\nThen: " + b.intent_after_next(f).text
	frag_label.text = "EMBER FRAGMENT\nCharge %d / %d  [%s%s]\nAt 3 attacks, all enemies\nget 3 Ignite + Weak 1" % [
		b.charge, Battle.CHARGE_MAX, "#".repeat(b.charge), "-".repeat(Battle.CHARGE_MAX - b.charge)]
	energy_label.text = "Energy %d / %d" % [b.energy, Battle.ENERGY]
	piles_label.text = "Deck %d · Draw %d · Discard %d · Faded %d" % [run_deck.size(), b.draw_pile.size(), b.discard.size(), b.faded.size()]
	var lines: Array = b.log_lines.slice(maxi(0, b.log_lines.size() - 5))
	log_label.text = "\n".join(lines)
	_build_hand()
	end_btn.disabled = b.result != ""
	if b.result != "" and not end_box.visible and not reward_box.visible:
		_on_fight_over()


func _build_hand() -> void:
	for c in cards:
		c.queue_free()
	cards = []
	var n: int = b.hand.size()
	var start_x := 640.0 - n * (CARD_SIZE.x + 10) / 2.0
	for i in n:
		var c: Dictionary = Battle.CARDS[b.hand[i]]
		var color := Color("7a3434") if c.type == "attack" else Color("34507a")
		if c.cost > b.energy:
			color = color.darkened(0.55)
		var p := _panel(Vector2(start_x + i * (CARD_SIZE.x + 10), HAND_Y), CARD_SIZE, color)
		var l := _wrapped(_label(Vector2(10, 8), 17, p), Vector2(CARD_SIZE.x - 20, CARD_SIZE.y - 16))
		l.text = "(%d) %s\n\n%s" % [c.cost, c.name, c.desc]
		cards.append(p)


func _flash(p: Panel) -> void:
	p.modulate = Color(2.2, 1.6, 0.6)
	create_tween().tween_property(p, "modulate", Color.WHITE, 0.6)


func _panel(pos: Vector2, size: Vector2, color: Color) -> Panel:
	var p := Panel.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = color
	sb.set_corner_radius_all(8)
	p.add_theme_stylebox_override("panel", sb)
	p.position = pos
	p.size = size
	p.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(p)
	return p


func _label(pos: Vector2, font_size: int, parent: Node = self) -> Label:
	var l := Label.new()
	l.position = pos
	l.add_theme_font_size_override("font_size", font_size)
	l.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(l)
	return l


# Wrapping must be on before the size is set, or the label keeps its one-line width.
func _wrapped(l: Label, size: Vector2) -> Label:
	l.autowrap_mode = TextServer.AUTOWRAP_WORD
	l.size = size
	return l
