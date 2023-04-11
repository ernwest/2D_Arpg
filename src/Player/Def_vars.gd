const speed: int = 200;
const projectile_node: PackedScene = preload("res://src/Spells/SpellTech/Projectile.tscn")
const playeraoe_node: PackedScene = preload("res://src/Spells/SpellTech/PlayerAoE.tscn")
const spell_nodes: Array = [projectile_node, playeraoe_node]

const maximum_evade: int = 90
const maximum_armor: int = 90
