extends HBoxContainer

var spell_bar: SpellBar
@export var spell_ui: PackedScene
@export var spell_text_ui: PackedScene

var node_spell_text_ui: Node

var ui_spellchooser_main: CanvasLayer
var ui_spellchooser: GridContainer

var pressed_spell: Node

var hotkeys: Array

func _ready():
	hotkeys = GUI.player.spell_bar.hotkeys
	GUI.ui_spell_bar = self
	ui_spellchooser_main = get_tree().get_current_scene().get_node("UI_SpellChooser")
	ui_spellchooser = ui_spellchooser_main.get_node("Cont/Panel/Grid")
	
	spell_bar = get_tree().get_current_scene().get_node("Player").spell_bar
	node_spell_text_ui = spell_text_ui.instantiate()
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
	butt.mouse_entered.connect(_on_button_mouse_entered.bind(new_node))
	butt.mouse_exited.connect(_on_button_mouse_exited.bind(new_node))
	
	var sp: Dictionary = GUI.player.sync_spell_with_player(spell_bar.spell_bar[i])
	set_node(new_node, sp)
	new_node.set_hotkey(hotkeys[i])
	
	if parent != ui_spellchooser:
		create_popup(new_node)
	
	if parent == ui_spellchooser:
		new_node.is_spellchooser = true

	parent.add_child(new_node)
		
func set_node(_node: Node, spell: Dictionary):
	_node.set_spell_name(spell.name)
	_node.set_spell_prefs(spell)
	_node.set_ui_icon(load(spell.techprefs.ui_icon))
	
func create_popup(new_node: Node):
	var popup: Node = node_spell_text_ui.duplicate()
	popup.hide()
	popup.unfocusable = true
	new_node.spell_popup = popup
	new_node.set_popup_text()
	new_node.add_child(popup)

func _on_spell_pressed(new_node):
	if new_node.is_spellchooser:
		GUI.change_spellbar(new_node, pressed_spell, ui_spellchooser_main)
	else:
		pressed_spell = new_node
		GUI.change_visible(ui_spellchooser_main)
	

func _on_button_mouse_entered(new_node):
	if new_node.is_spellchooser: return
	var popup: Node = new_node.get_node("UI_Spell_Text")
	popup.position = get_global_mouse_position()
	popup.position.y -= popup.size.y
	popup.popup()

func _on_button_mouse_exited(new_node):
	if new_node.is_spellchooser: return
	new_node.get_node("UI_Spell_Text").hide()
	
	
	
