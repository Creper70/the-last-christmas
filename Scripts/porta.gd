extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	# Toca o som da porta antes de trocar de cena
	AudioManager.play_door_sound()
	
	var current_scene_path = get_tree().current_scene.scene_file_path
	print(current_scene_path)
	
	if current_scene_path == "res://Scenes/FirstStage.tscn":
		Global.last_door = "from_first"
		get_tree().change_scene_to_file("res://Scenes/second_stage.tscn")

	elif current_scene_path == "res://Scenes/second_stage.tscn":
		Global.last_door = "from_second"
		get_tree().change_scene_to_file("res://Scenes/third_stage.tscn")

	elif current_scene_path == "res://Scenes/third_stage.tscn":
		Global.last_door = "from_third"
		get_tree().change_scene_to_file("res://Scenes/fourth_stage.tscn")

	elif current_scene_path == "res://Scenes/fourth_stage.tscn":
		Global.last_door = "from_fourth"
		get_tree().change_scene_to_file("res://Scenes/fifth_stage.tscn")
