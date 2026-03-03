extends Node2D

@onready var player = $Player
@onready var Key = $Key
@onready var animation = $AnimationPlayer
@onready var one_time = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_unlockPlayer)
	if Global.last_door == "from_fifth_back":
		player.set_position(Vector2(2950, -43))
	
	if Global.last_door == "from_third":
		player.set_position(Vector2(79, 1045))
	if Global.have_key == true:
		$Label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.Fourth_Stage_elfsdead == true and Global.have_key == false and one_time == false:
		$Label.hide()
		Key.show()
		animation.play("KeyFalling")
		one_time = true


func _on_key_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Key.queue_free()
		Global.have_key = true
		$Player.lockPlayer()
		Dialogic.start("keyGot")

func _unlockPlayer(argument: String):
	if argument == "UnlockPlayer":
		$Player.unlockPlayer()
