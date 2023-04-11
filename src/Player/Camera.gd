extends Camera2D

@export var player: Node
var interpolate_speed: float = 4
var interp_range: float = 1
var new_pos: Vector2
var move_vec: Vector2
var range_kof: int = 75

func _ready():
	if player == null:
		find_player()
	
func _physics_process(delta):	
	if position == player.position: return
	interpolate_pos()
	
func interpolate_pos():
	new_pos = Vector2.ZERO
	
	if player.is_moving:
		camera_forward()
	else:
		return_to_player()
		
	position += new_pos
	
func camera_forward():
	move_vec = player.position + player.move_vector * range_kof
	
	new_pos.x = move_vec.x - position.x
	if new_pos.x > interp_range or new_pos.x < -interp_range:
		new_pos.x /= interpolate_speed
		
	new_pos.y = move_vec.y - position.y
	if new_pos.y > interp_range or new_pos.y < -interp_range:
		new_pos.y /= interpolate_speed
	
func return_to_player():
	new_pos.x = (player.position.x - position.x)
	if new_pos.x > interp_range or new_pos.x < -interp_range:
		new_pos.x /= interpolate_speed
		
	new_pos.y = (player.position.y - position.y)
	if new_pos.y > interp_range or new_pos.y < -interp_range:
		new_pos.y /= interpolate_speed

func find_player():
	player = get_node_or_null("../Player")
		
	






