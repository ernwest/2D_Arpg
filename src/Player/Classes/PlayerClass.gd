class_name PlayerClass extends Node

var json_skills: Dictionary
var playerclass: int
var spells: Dictionary
var pl_class: String

enum EPlayerClass {
	Mage,
	Warrior
}
func _init():
	var path: String = pl_class
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var json: String = file.get_as_text()
	
	json_skills = JSON.parse_string(json)
	
	create_skills()
	
func create_skills():
	for skill in json_skills:
		var s: Dictionary = json_skills[skill]
		spells[s.name] = s
		
func get_spells():
	return spells














