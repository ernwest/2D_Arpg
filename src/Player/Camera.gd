extends Camera2D

@export var player: Node
var interpolate_speed: float = 6

func _ready():
	if player == null:
		find_player()
	
func _physics_process(delta):	
	if position == player.position: return
	interpolate_pos()
	
func interpolate_pos():
	var new_pos: Vector2 = Vector2.ZERO

	new_pos.x = (player.position.x - position.x) / interpolate_speed
	new_pos.y = (player.position.y - position.y) / interpolate_speed
	
	position += new_pos

func find_player():
	player = get_node_or_null("../Player")
		
	






