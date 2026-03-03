extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Global.last_door == "from_third_back":
		$Player.set_position(Vector2(1943,201))
	if Global.last_door == "from_first":
		$Player.set_position(Vector2(-143,211))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
