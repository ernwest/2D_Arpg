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
		var new_node: Control = ui_spell_node.duplicate(true)
		var butt: Button = new_node.get_node("Button")
		butt.button_down.connect(_on_spell_pressed)
		add_child(new_node)

func _on_spell_pressed():
	print(123)
