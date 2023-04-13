extends CanvasLayer

@export var player: Player

func _process(delta):
	if Input.is_action_just_pressed("LMB") and player._mouse_entered:
		player._mouse_in_inventory = true
		
func change_visible():
	visible = !visible
	clear_vars()
	
func clear_vars():
	player._mouse_entered = false
	player._mouse_in_inventory = false

func _on_item_list_mouse_entered():
	player._mouse_entered = true

func _on_item_list_mouse_exited():
	clear_vars()
