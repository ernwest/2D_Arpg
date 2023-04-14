extends Node

var spell_name
var spell_prefs: Dictionary
var spell_hotkey: String

var is_spellchooser: bool = false
var pressed: bool = false

func set_spell_name(_n: String):
	spell_name = _n	
	
func set_spell_prefs(_prefs: Dictionary):
	spell_prefs = _prefs

func set_ui_icon(_icon: String):
	get_node("Button").icon = load(_icon)

func set_hotkey(_hk: String):
	spell_hotkey = _hk
	get_node("hotkey").text = _hk

############################

func _on_mouse_entered():
	GUI.set_ui_focus()

func _on_mouse_exited():
	GUI.clear_vars()
