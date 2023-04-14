extends Control

var player: Player

var _mouse_in_ui: bool = false

func change_visible(_node: Node):
	_node.visible = !_node.visible
	clear_vars()

func clear_vars():
	_mouse_in_ui = false

func set_ui_focus():
	_mouse_in_ui = true
