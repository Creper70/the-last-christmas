extends Node2D
class_name Enemy


var life = 10
@onready var locations = [$"../location1", $"../location2", $"../location3"]
var my_location = null
var is_killed = false
@onready var dead_texture = load("res://Sprites/assets/ElfoMorto.png")
@onready var scared_texture_up = load("res://Sprites/assets/ElfoAssustado1.png")
@onready var scared_texture_right = load("res://Sprites/assets/ElfoAssustado3.png")


func _ready() -> void:
	if Global.Fourth_Stage_elfsdead == true:
		$Sprite2D.set_texture(dead_texture)
		$Sprite2D.set_scale(Vector2(1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.has_shooted and is_killed == false:
		run()


func take_hit(damage: int):
	var current_scene_path = get_tree().current_scene.scene_file_path
	life -= damage
	if life <= 0:
		is_killed = true
		Global.KillCount += 1
		print(Global.KillCount)
		$Sprite2D.set_texture(dead_texture)
		$Sprite2D.set_scale(Vector2(1, 1))
		if current_scene_path == "res://Scenes/fourth_stage.tscn":
			Global.Fourth_Stage_elfsdead = true



func run():
	if Global.has_shooted == true and is_killed == false:
		if my_location != null:
			return
		for slot in locations:
			# Verifica se o slot existe (pode ser null em outras cenas)
			if slot == null:
				continue
			if slot.ocupado == false:
				if is_killed:
					return
				slot.ocupado = true
				my_location = slot
				if is_killed:
					return
				if slot == locations[0]:
					$Sprite2D.set_texture(scared_texture_up)
					$Sprite2D.set_scale(Vector2(1, 1))
				else:
					$Sprite2D.set_texture(scared_texture_right)
					$Sprite2D.set_scale(Vector2(1, 1))
				self.set_position(my_location.get_position())
				break
