class_name NPCLoader extends Node2D

var json_npc: Dictionary
var npcs: Array
var packed_scene: PackedScene = preload("res://src/NPC/Enemy/Enemy.tscn")
@export var npc_type: int = 1

enum ENpcType {
	Unnamed,
	Enemy,
	Vendor
}

func _init():
	var path: String = get_npc_path()
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var json: String = file.get_as_text()
	
	json_npc = JSON.parse_string(json)
	
	create_npc()
	
func get_npc_path():
	var return_path: String = ""
	match npc_type:
		ENpcType.Unnamed:
			return_path = "1"
		ENpcType.Enemy:
			return_path = "res://src/NPC/enemy.json"
		ENpcType.Vendor:
			return_path = "2"
		_:
			return_path = "3"
	
	return return_path
	
func create_npc():
	for npc in json_npc:
		var n: Dictionary = json_npc[npc]
		npcs.push_back(n)
		
func get_npcs():
	return npcs

func get_packed_scene():
	return packed_scene












