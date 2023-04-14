extends HBoxContainer

var spell_bar: SpellBar
@export var spell_ui: PackedScene

var ui_spellchooser_main: CanvasLayer
var ui_spellchooser: GridContainer

var pressed_spell: Node

var hotkeys: Array = ["Q", "W", "E", "R"]

func _ready():
	ui_spellchooser_main = get_tree().get_current_scene().get_node("UI_SpellChooser")
	ui_spellchooser = ui_spellchooser_main.get_node("Cont/Panel/Grid")
	
	spell_bar = get_tree().get_current_scene().get_node("Player").spell_bar
	fill_spell_bar_ui()
	
func fill_spell_bar_ui():
	var spells_count: int = spell_bar.spell_bar.size()
	if spells_count == 0: return
	var ui_spell_node: Node = spell_ui.instantiate()
	
	for i in spells_count:
		ui_create_spells(ui_spell_node, i, self)
		ui_create_spells(ui_spell_node, i, ui_spellchooser)
		
func ui_create_spells(_node: Node, i: int, parent: Node):
	var new_node: Control = _node.duplicate()
	var butt: Button = new_node.get_node("Button")
	butt.button_down.connect(_on_spell_pressed.bind(new_node))
		
	set_node(new_node, spell_bar.spell_bar[i])
	new_node.set_hotkey(hotkeys[i])
	
	if parent == ui_spellchooser:
		new_node.is_spellchooser = true
	
	parent.add_child(new_node)
		
func set_node(_node: Node, spell: Dictionary):
	_node.set_spell_name(spell.name)
	_node.set_spell_prefs(spell)
	_node.set_ui_icon(spell.techprefs.ui_icon)

func _on_spell_pressed(new_node):
	if new_node.is_spellchooser:
		GUI.change_spellbar(new_node, pressed_spell, ui_spellchooser_main)
	else:
		pressed_spell = new_node
		GUI.change_visible(ui_spellchooser_main, true)
	
	
	
	
	
