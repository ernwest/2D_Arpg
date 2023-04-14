extends CanvasLayer

func _on_item_list_mouse_entered():
	GUI.set_ui_focus()

func _on_item_list_mouse_exited():
	GUI.clear_vars()
