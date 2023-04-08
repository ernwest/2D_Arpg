class_name EnemyCreator extends Node2D

@export var min_mob_count: int
@export var max_mob_count: int
@export var range: int = 150
var mob_count: int
var mob_node: Enemy
var npc_loader: NPCLoader
var enemy_mods: Dictionary

func _ready():	
	enemy_mods = ModsEnemies.added_prefs.duplicate(true)
	npc_loader = $"../NPCEnemyLoader"
	
	mob_count = _mobs_counts()
	mob_node = create_mob_node()
	
	await get_tree().create_timer(0.1).timeout
	spawn_mobs(mob_node)
	
func _mobs_counts():	
	var return_rand: int
	return_rand = randi_range(min_mob_count, max_mob_count)
	
	if min_mob_count == max_mob_count:
		return_rand = max_mob_count
		
	return return_rand
	
func create_mob_node():
	var packed: PackedScene = npc_loader.get_packed_scene()
	var enemy_node: Enemy = packed.instantiate()
	
	var npc: Dictionary = npc_loader.npcs[0]
	
	var texture: Texture2D = load(npc.techprefs.sprite)
	var sprite: Sprite2D = enemy_node.get_node("Sprite")
	
	sprite.texture = texture
	
	enemy_node._name = npc.name
	enemy_node.prefs = npc.gameprefs.duplicate(true)
	sync_prefs_with_global(enemy_node.prefs)
	
	enemy_node.position = position
	
	return enemy_node
	
func spawn_mobs(mob_node: Enemy):
	for i in range(0, mob_count):
		var node: Enemy = mob_node.clone_enemy()
		node.position = get_rand_position()
		self.add_child(node)
	
func get_rand_position():
	var return_pos: Vector2 = Vector2.ZERO
	
	return_pos.x = randi_range(-range, range)
	return_pos.y = randi_range(-range, range)
	
	return return_pos
	
func sync_prefs_with_global(_prefs: Dictionary):
	_prefs.merge(enemy_mods)
	
	_prefs.health *= _prefs.inc_health
	_prefs.damage *= _prefs.inc_damage
	_prefs.speed *= _prefs.inc_speed
	_prefs.attack_speed *= _prefs.inc_attack_speed
	_prefs.projectiles += _prefs.added_projectiles
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
