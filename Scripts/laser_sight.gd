extends Line2D

@onready var raycast = get_parent()

func _ready() -> void:
	width = 2.0
	default_color = Color(1.0, 0.0, 0.0, 0.5)  # Vermelho transparente
	z_index = 5

func _process(delta: float) -> void:
	if visible:
		update_laser()

func update_laser() -> void:
	clear_points()
	
	var start_pos = Vector2.ZERO
	var end_pos = raycast.target_position
	
	# Se o raycast colidiu, encurta o laser até o ponto de colisão
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		var local_collision = raycast.to_local(collision_point)
		end_pos = local_collision
	
	add_point(start_pos)
	add_point(end_pos)
