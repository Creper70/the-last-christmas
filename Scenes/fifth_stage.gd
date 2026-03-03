extends Node2D

@onready var puzzle = $PuzzleCor
var one_time = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $PuzzleCor.visible == false:
		$Player.unlockPlayer()
	if $PuzzleCor.visible == false and Global.puzzle_resolvido == true and one_time == false:
		$Player.unlockPlayer()
		$Player.set_position(Vector2(887,-37))
		one_time = true

func _on_porta_body_entered(body: Node2D) -> void:
	if Global.puzzle_resolvido == false:
		puzzle.show()
		$Player.lockPlayer()
	if Global.puzzle_resolvido == true:
		get_tree().change_scene_to_file("res://Scenes/final_stage.tscn")
