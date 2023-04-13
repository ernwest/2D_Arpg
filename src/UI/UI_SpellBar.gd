extends HBoxContainer

var spell_bar: SpellBar
@export var spell_ui: PackedScene

func _ready():
	spell_bar = get_tree().get_current_scene().get_node("Player").spell_bar
	fill_spell_bar_ui()
	
func fill_spell_bar_ui():
	var spells_count: int = spell_bar.spell_bar.size()
	if spells_count == 0: return
	var ui_spell_node: Node = spell_ui.instantiate()
	
	for i in spells_count:
		var new_node: Control = ui_spell_node.duplicate()
		var butt: Button = new_node.get_node("Button")
		butt.button_down.connect(_on_spell_pressed.bind(new_node))
		
		set_node(new_node, spell_bar.spell_bar[i])
		add_child(new_node)
		
func set_node(_node: Node, spell: Dictionary):
	_node.set_spell_name(spell.name)
	_node.set_spell_prefs(spell.gameprefs)

func _on_spell_pressed(new_node):
	print(new_node.spell_name)
