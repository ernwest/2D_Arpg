extends AspectRatioContainer


var spell_name
var spell_prefs: Dictionary
var spell_hotkey: String
var ui_icon: Texture2D

var is_spellchooser: bool = false
var pressed: bool = false

var spell_popup: Node

func set_popup_text(text: String = ""):
	if text == "": set_def_text()
	else: spell_popup.get_node("Text").text = text

func set_def_text():
	spell_popup.get_node("Text").text = ""
	spell_popup.get_node("Text").text += str("Название: ", spell_name, "\n")
	spell_popup.get_node("Text").text += str("Урон: ", spell_prefs.gameprefs.damage, "\n")
	spell_popup.get_node("Text").text += str("Кулдаун: ", spell_prefs.gameprefs.cooldown, "\n")
	spell_popup.get_node("Text").text += str("Манакост: ", spell_prefs.gameprefs.manacost, "\n")

func set_spell_name(_n: String):
	spell_name = _n	
	
func set_spell_prefs(_prefs: Dictionary):
	spell_prefs = _prefs

func set_ui_icon(_icon: Texture2D):
	ui_icon = _icon
	get_node("Button").icon = ui_icon

func set_hotkey(_hk: String):
	spell_hotkey = _hk
	get_node("hotkey").text = _hk
