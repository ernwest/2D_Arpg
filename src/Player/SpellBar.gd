class_name SpellBar extends Node2D

var spell_bar: Array = []

func get_spell(id: int) -> Dictionary:
	return spell_bar[id]

func push_spells_to_bar(cl: PlayerClass):
	for spell in cl.spells:
#		var sp: Spell = cl.spells[spell]
		var sp: Dictionary = cl.spells[spell]
		spell_bar.push_back(sp)
