class_name SpellBar extends Node2D

var spell_bar: Array = []
var hotkeys: Array = ["Q", "W"]
var spell_hk: Dictionary

func get_spell(id: int) -> Dictionary:
	return spell_bar[id]

func push_spells_to_bar(cl: PlayerClass):
	for spell in cl.spells:
#		var sp: Spell = cl.spells[spell]
		var sp: Dictionary = cl.spells[spell]
		spell_bar.push_back(sp)

func push_spells_to_dict(cl: PlayerClass):
	var i: int = 0
	for spell in cl.spells:
		var sp: Dictionary = cl.spells[spell]
		spell_hk[hotkeys[i]] = sp
		i += 1
