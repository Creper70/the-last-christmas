extends Node2D

@export var glow_color: Color = Color(1.0, 0.9, 0.3, 1.0)  # Amarelo dourado
@export var glow_size: float = 40.0
@export var pulse_speed: float = 2.0

var time: float = 0.0

func _ready() -> void:
	# Cria o visual do brilho
	queue_redraw()

func _process(delta: float) -> void:
	time += delta * pulse_speed
	queue_redraw()

func _draw() -> void:
	# Calcula a intensidade do pulse (vai de 0.5 a 1.0)
	var pulse = 0.5 + abs(sin(time)) * 0.5
	
	# Desenha 3 círculos pra criar efeito de glow
	# Círculo externo (mais transparente)
	var outer_color = glow_color
	outer_color.a = 0.2 * pulse
	draw_circle(Vector2.ZERO, glow_size * pulse, outer_color)
	
	# Círculo médio
	var mid_color = glow_color
	mid_color.a = 0.4 * pulse
	draw_circle(Vector2.ZERO, glow_size * 0.6 * pulse, mid_color)
	
	# Círculo interno (mais brilhante)
	var inner_color = glow_color
	inner_color.a = 0.8 * pulse
	draw_circle(Vector2.ZERO, glow_size * 0.3 * pulse, inner_color)
