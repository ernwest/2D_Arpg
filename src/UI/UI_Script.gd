extends CanvasLayer

@export var player: Player

@export var health_text: RichTextLabel
@export var mana_text: RichTextLabel

var caret: String = " / "

var current_health: int
var max_health: int 
var current_mana: int
var max_mana: int 

func _physics_process(delta):
	current_health = player.prefs.current_health
	max_health = player.prefs.max_health
	current_mana = player.prefs.current_mana
	max_mana = player.prefs.max_mana
	
	health_text.text = str( current_health, caret, max_health )
	mana_text.text = str( current_mana, caret, max_mana )
