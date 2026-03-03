extends Line2D

@export var lifetime: float = 0.15
@export var fade_speed: float = 5.0

var time_alive: float = 0.0

func _ready() -> void:
	width = 3.0
	default_color = Color(1.0, 0.8, 0.2, 1.0)  # Amarelo brilhante
	z_index = 10
	
func _process(delta: float) -> void:
	time_alive += delta
	
	# Fade out
	var alpha = 1.0 - (time_alive / lifetime)
	default_color.a = clamp(alpha, 0.0, 1.0)
	
	# Diminui a largura
	width = lerp(3.0, 0.5, time_alive / lifetime)
	
	if time_alive >= lifetime:
		queue_free()
