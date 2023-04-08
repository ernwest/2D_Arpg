class_name Enemy extends NPC

@export var explosive: PackedScene
@export var death_audio: PackedScene

var playernode: Player
var go_to_player: bool
var _name: String
var prefs: Dictionary = {}

var dead: bool = false;

var is_playeraoe_hitting: bool = false
var is_player_aoe_can_hit: bool = true
var playeraoe_spell: Spell

var is_player_close: bool = false
var can_hit_player: bool = true

func _ready():
	print( prefs )

func _process(delta):
	if dead: return
	
	
	if is_playeraoe_hitting and is_player_aoe_can_hit:
		playeraoe_hit(playeraoe_spell)
		
	if is_player_close:
		player_hit(playernode)
	
	if go_to_player:
		velocity = playernode.position - global_position
		velocity = velocity.normalized()
		velocity *= prefs.speed
		move_and_slide()
		
func _on_collision_detection_body_entered(body):
	if body.is_in_group("Projectile"):
		projectile_hit(body)
	elif body.is_in_group("PlayerAoE"):
		playeraoe_hit(body)
	elif body.is_in_group("Player"):
		is_player_close = true
		player_hit(body)
		
func _on_collision_detection_body_exited(body):
	if body.is_in_group("PlayerAoE"):
		playeraoe_exit(body)
	elif body.is_in_group("Player"):
		is_player_close = true

func projectile_hit(_spell: Spell):
	var damage: int = _spell.gameprefs.damage
	prefs.health -= damage
	_spell.hit()
	
	if prefs.health <= 0:
		die()
		
func playeraoe_hit(_spell: Spell):
	if !is_playeraoe_hitting:
		playeraoe_spell = _spell
		is_playeraoe_hitting = true
	
	var damage: int = _spell.gameprefs.damage
	prefs.health -= damage
	_spell.hit()
	
	if prefs.health <= 0:
		die()
		
	is_player_aoe_can_hit = false
	await get_tree().create_timer( _spell.gameprefs.hit_cd ).timeout
	is_player_aoe_can_hit = true
	
func playeraoe_exit(_spell: Spell):
	is_playeraoe_hitting = false
		
func die():
	var e = explosive.instantiate()
	var a = death_audio.instantiate()
	
	e.global_position = global_position
	a.global_position = global_position
	
	get_tree().get_current_scene().add_child(e)
	get_tree().get_current_scene().add_child(a)
	
	e.emitting = true
	a.playing = true
	
	queue_free()
	
func player_hit(_pl: Player):
	if !can_hit_player: return
	
	var damage: int = prefs.damage
	
	_pl.hit_player(damage)
	can_hit_player = false
	await get_tree().create_timer(1).timeout
	can_hit_player = true

func _on_view_area_body_entered(body):
	if body.is_in_group("Player"):
		set_follow(body)

func set_follow(_pl: Player):
	playernode = _pl
	go_to_player = true

	
func clone_enemy():
	var node: Enemy = self
	var new_node: Enemy
	
	new_node = node.duplicate()
#	new_node.get_node()

	new_node._name = node._name
	new_node.prefs = node.prefs.duplicate(true)
	
	return new_node
