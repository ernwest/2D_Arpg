extends CanvasLayer

var mouse_in_inventory: bool = false
var mouse_entered: bool = false

func _process(delta):
	if Input.is_action_just_pressed("LMB") and mouse_entered:
		mouse_in_inventory = true
		
func change_visible():
	visible = !visible
	clear_vars()
	
func clear_vars():
	mouse_entered = false
	mouse_in_inventory = false

func _on_item_list_mouse_entered():
	mouse_entered = true

func _on_item_list_mouse_exited():
	clear_vars()
