class_name Player extends CharacterBody2D

# Character prefs
var _name: String = "Player"

var health: int = 100
var _class: PlayerClass

# inc - increase
# red - reduce
var prefs: Dictionary = {
	"current_health" = 100,
	"max_health" = 756,
	"health_regen" = 5,
	"health_regen_percent" = 1,
	
	"current_mana" = 100,
	"max_mana" = 100,
	"mana_regen" = 5,
	"mana_regen_percent" = 5,
	
	"evasion" = 5000, # 1000 = 10%
	"armor" = 1000, # 1000 = 10%
	
	#"evasion_percent" = 10,
	#"armor_percent" = 10,
	
	"vampiric_health" = 10, # percent from damage
	"vampiric_mana" = 1, # percent from damage
	
	"speed_multi" = 7.2,
	
	"added_damage" = 800,
	"added_projectiles" = 3,
	
	"inc_damage" = 1.1,
	"inc_aoe" = 2.0,
	
	"red_cooldown" = 2.0
}

func fill_player_info(pl_name: String, cl: PlayerClass):
	_name = pl_name
	_class = cl
	
func fill_player_prefs(_prefs: Dictionary):
	prefs = _prefs
	
	
	
	
	
	
	
	
	
