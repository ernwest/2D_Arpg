class_name Projectile extends Spell

var player_circle: Node2D
var player_circle_side: Node2D

var pirced: int = 0

func _ready():
	pass
	
func start():
	var speed: int = gameprefs.speed * 100
	var force = Vector2(1,0).rotated(rotation)
	apply_force(force*speed)
	
	await get_tree().create_timer(techprefs.lifetime).timeout
	queue_free()
	
func hit():
	super()
	pirced += 1
	if pirced == gameprefs.pierce:
		queue_free()
	
	
func spell_create(_scene_tree: Node2D, _player_circle: Node2D, spell: Dictionary):
	scene_tree = _scene_tree
	player_circle = _player_circle
	player_circle_side = player_circle.get_node("Circle_side")
	
	var node_spell: Spell = self
	var step: int = spell.gameprefs.angle
	var angle: int = 0
	var proj_count: int = spell.gameprefs.projectiles
	var circle_start_deg: float = player_circle.rotation_degrees
	var i: int = 0

	if proj_count % 2 != 0:
		proj_count -= 1
		fire_proj(node_spell, angle, i-1, step)

	while( i < proj_count ):
		player_circle.rotation_degrees = circle_start_deg
		angle = fire_proj(node_spell, angle, i, step)
		i += 1

func fire_proj(node_spell: Spell, angle: int, i: int, step: int):
	var copy: Spell = node_spell.clone_spell()

	if i % 2 == 0:
		angle = -(abs(angle)+step)

	var new_angle: int
	if angle > 0: new_angle = angle - step/2
	else: new_angle = angle + step/2
	
	player_circle.rotation_degrees += new_angle
		

	copy.position = player_circle_side.global_position
	copy.rotation_degrees = player_circle.rotation_degrees

	scene_tree.add_child(copy)
	copy.start()

	return -angle
	
func fire_proj_2(node_spell: Spell, angle: int, i: int, step: int):
	var copy: Spell = node_spell.clone_spell()

	if i % 2 == 0:
		angle = -(abs(angle)+step)

	player_circle.rotation_degrees += angle

	copy.position = player_circle_side.global_position
	copy.rotation_degrees = player_circle.rotation_degrees

	scene_tree.add_child(copy)
	copy.start()

	return -angle
	
	
	
	
