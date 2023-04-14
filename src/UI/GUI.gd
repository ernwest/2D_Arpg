extends Control

var player: Player

var _mouse_in_ui: bool = false

func change_visible(_node: Node, always_show: bool = false):
	if always_show: 
		_node.visible = true
	else:
		_node.visible = !_node.visible
	clear_vars()

func clear_vars():
	_mouse_in_ui = false

func set_ui_focus():
	_mouse_in_ui = true

func change_spellbar(new_spell: Node, old_spell: Node, _spell_bar: Node):
	old_spell.spell_name = new_spell.spell_name
	old_spell.spell_prefs = new_spell.spell_prefs

	player.spell_bar.spell_hk[old_spell.spell_hotkey] = new_spell.spell_prefs
	
	change_visible(_spell_bar)
	
	
	
	
	
	
	
	
	
