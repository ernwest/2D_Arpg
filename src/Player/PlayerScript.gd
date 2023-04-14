extends Player

@export var ui_main: CanvasLayer
@export var ui_inventory: CanvasLayer

var default_vars: GDScript = preload("res://src/Player/Def_vars.gd")

var player: Player
var spell_bar: SpellBar = SpellBar.new()

var player_circle: CollisionShape2D
var player_circle_side: Node2D

var skills_cooldowns: Array = [true, true]

var move_vector: Vector2 = Vector2.ZERO
var speed_sum: float  = default_vars.speed

var audio: AudioStreamPlayer2D
var camera: Camera2D

var is_regen: bool = false
var is_moving: bool = false

# Player info
var _n: String = "Alo da"
var _cl: PlayerClass = Mage.new()
#

func _ready():
	player = self
	GUI.player = player
	player_circle = $Circle
	player_circle_side = $Circle/Circle_side
	audio = $Audio
	camera = $"../PlayerCamera"
	
	spell_bar.push_spells_to_bar(_cl)
	player_creator(player)
	
func _process(delta):
	player_circle_look_at()
	spell_input_handler()
	
	if !is_regen:
		regen()

func _physics_process(delta):
	move_input_handler()
	speed_sum = default_vars.speed * player.prefs.speed_multi
	move_and_collide(move_vector * speed_sum * delta)
	
func regen():
	is_regen = true
	var health_percent: int = player.prefs.health_regen_percent * player.prefs.max_health / 100
	var mana_percent: int = player.prefs.mana_regen_percent * player.prefs.max_mana / 100
	
	var total_health_sum: int = player.prefs.health_regen + health_percent
	var total_mana_sum: int = player.prefs.mana_regen + mana_percent
	
	player.prefs.current_health += total_health_sum
	player.prefs.current_mana += total_mana_sum
	
	player.prefs.current_health = clamp(player.prefs.current_health, player.prefs.current_health, player.prefs.max_health)
	player.prefs.current_mana = clamp(player.prefs.current_mana, player.prefs.current_mana, player.prefs.max_mana)
	await get_tree().create_timer(1).timeout
	is_regen = false
	
func player_circle_look_at():
	player_circle.look_at( get_global_mouse_position() )

func player_creator(_player: Player):
	_player.fill_player_info(_n, _cl)

func move_input_handler():
	move_vector = Vector2.ZERO
	is_moving = false
	mouse_input()
	keyboard_input()
		
func mouse_input():
	if Input.is_action_pressed("LMB"):
		if GUI._mouse_in_ui: return
		var mouse_pos: Vector2 = mouse_pos_relative_player()
		if mouse_pos != Vector2.ZERO:
			is_moving = true
		move_vector = mouse_pos
		
func keyboard_input():
	if Input.is_action_just_pressed("Inventory"):
		GUI.change_visible(ui_inventory)

func spell_input_handler():
	if Input.is_action_pressed("Q") and skills_cooldowns[0]:
		init_spell(0)
	if Input.is_action_pressed("W") and skills_cooldowns[1]:
		init_spell(1)
		
func init_spell(id: int):
	start_spell(id)
	set_cooldown(id)
		
func set_cooldown(id: int):
	var timer: float
	timer = spell_bar.get_spell(id).gameprefs.cooldown
	timer /= player.prefs.red_cooldown
	
	skills_cooldowns[id] = false
	await get_tree().create_timer(timer).timeout
	skills_cooldowns[id] = true

func start_spell(spell_bar_id: int): 
	var spell: Dictionary = spell_bar.get_spell(spell_bar_id).duplicate(true)
	
	if spell.gameprefs.manacost > player.prefs.current_mana: return
	player.prefs.current_mana -= spell.gameprefs.manacost
	
	var node_spell: Spell = spell_node_creator(spell)
	node_spell.player = player
	
	audio.stream = load(spell.techprefs.audio)
	audio.playing = true
	

	var type: int = spell.type
	match type:
		Spell.ETYPE.Projectile:
			var _scene_tree: Node2D = get_tree().get_current_scene()
			node_spell.spell_create(_scene_tree, player_circle, spell)
		Spell.ETYPE.PlayerAoE:
			var _scene_tree: Node2D = get_tree().get_current_scene()
			node_spell.spell_create(_scene_tree, spell)
		

func spell_node_creator(spell: Dictionary):
	var spritePath: String = spell.techprefs.sprite
	var texture: Texture2D = load(spritePath)
	
	var spell_packed: PackedScene = get_packed_spell_node(spell.type)
	var node_spell: Spell = spell_packed.instantiate()
	
	var node_sprite: Sprite2D = node_spell.get_node("Sprite")
	var node_collision: CollisionShape2D = node_spell.get_node("Collision")
	
	var updated_spell: Dictionary = sync_spell_with_player(spell)
	
	if updated_spell.gameprefs.has("aoe"):
		var _scale: int = updated_spell.gameprefs.aoe
		node_sprite.scale *= _scale
		node_collision.scale *= _scale
		
	node_sprite.texture = texture
	
	node_spell.set_props(updated_spell)
	
	return node_spell
	
func sync_spell_with_player(_spell: Dictionary):
	var s_prefs: Dictionary = _spell.gameprefs
	var p_prefs: Dictionary = player.prefs
	
	if _spell.type != Spell.ETYPE.Aura:
		s_prefs.damage += p_prefs.added_damage
		s_prefs.damage *= p_prefs.inc_damage
	
	if _spell.type == Spell.ETYPE.Projectile:
		s_prefs.damage += p_prefs.added_projectile_damage
		s_prefs.damage *= p_prefs.inc_projectile_damage
		s_prefs.projectiles += p_prefs.added_projectiles
	
	if _spell.type == Spell.ETYPE.PlayerAoE:
		s_prefs.damage += p_prefs.added_aoe_damage
		s_prefs.damage *= p_prefs.inc_aoe_damage
		s_prefs.aoe *= p_prefs.inc_aoe_radius
		
	if _spell.type == Spell.ETYPE.Aura:
		s_prefs.aoe *= p_prefs.inc_aoe_radius
	
	return _spell

func get_packed_spell_node(t: int):
	return default_vars.spell_nodes[t]

func hit_player(dmg: int):
	var evade: int = player.prefs.evasion / 100
	evade = clamp(evade, 0, default_vars.maximum_evade)
	if randi_range(0, 100) <= evade: return
	
	var armor: int = player.prefs.armor / 100
	armor = clamp(armor, 0, default_vars.maximum_armor)
	
	dmg -= armor * dmg / 100
	dmg = clamp(dmg, 0, abs(dmg))
	
	player.prefs.current_health -= dmg

func mouse_pos_relative_player():
	var mouse_pos: Vector2 = get_global_mouse_position()
	mouse_pos -= position
	mouse_pos = mouse_pos.normalized()
	return mouse_pos
