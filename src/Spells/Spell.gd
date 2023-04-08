class_name Spell extends RigidBody2D 

var _name: String
var type: int
var gameprefs: Dictionary
var techprefs: Dictionary

var player: Player
var scene_tree: Node2D

enum ETYPE {
	Projectile,
	PlayerAoE
}

func set_dict(spell: Dictionary = {}):
	_name = spell.name
	type = spell.type
	gameprefs = spell.gameprefs
	techprefs = spell.techprefs
	
func set_props(updated_spell: Dictionary):
	_name = updated_spell.name
	type = updated_spell.type
	gameprefs = updated_spell.gameprefs
	techprefs = updated_spell.techprefs

func hit():
	player.prefs.current_health += player.prefs.vampiric_health * gameprefs.damage / 100
	player.prefs.current_health = clamp(player.prefs.current_health, player.prefs.current_health, player.prefs.max_health)
	
	player.prefs.current_mana += player.prefs.vampiric_mana * gameprefs.damage / 100
	player.prefs.current_mana = clamp(player.prefs.current_mana, player.prefs.current_mana, player.prefs.max_mana)

func clone_spell():
	var node: Spell = self
	var new_node: Spell
	
	new_node = node.duplicate()
	new_node.player = node.player

	new_node._name = node._name
	new_node.type = node.type
	new_node.gameprefs = node.gameprefs.duplicate(true)
	new_node.techprefs = node.techprefs.duplicate(true)
	
	return new_node












