class_name PlayerAoE extends Spell

func _process(delta):
	position = player.position
	pass

func start():
	
	var texture: Texture2D = get_node("Sprite").get_texture()
	var collision: CollisionShape2D = get_node("Collision")
	
	collision.get_shape().radius = texture.get_size().x/2
	
#	position = Vector2.ZERO
	
	
	await get_tree().create_timer(techprefs.lifetime).timeout
	queue_free()

func spell_create(_scene_tree: Node2D, spell: Dictionary):
	scene_tree = _scene_tree
	scene_tree.add_child(self)
	self.start()
	
func hit():
	super()
