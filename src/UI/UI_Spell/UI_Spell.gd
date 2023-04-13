extends Node

var spell_name
var spell_prefs: Dictionary

var pressed: bool

func set_spell_name(_n: String):
	spell_name = _n	
	
func set_spell_prefs(_prefs: Dictionary):
	spell_prefs = _prefs
