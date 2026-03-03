extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_unlockPlayer)
	if Global.last_door == "from_second":
		$Player.set_position(Vector2(100,284))
	if Global.last_door == "from_fourth_back":
		$Player.set_position(Vector2(1679,281))
	if Global.last_door == "from_armazen_back":
		$Player.set_position(Vector2(897,-40))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _unlockPlayer(argument:String):
	if argument == "unlockPlayer":
		player.unlockPlayer()


func _on_porta_armazen_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player") and Global.have_key == false:
			player.lockPlayer()
			Dialogic.start("LockedDoor")
		if body.is_in_group("Player") and Global.have_key == true:
			#tocar som
			get_tree().create_timer(0.75)
			get_tree().change_scene_to_file("res://Scenes/armazen.tscn")
