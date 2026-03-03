extends Node2D

@onready var animation = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauPauNoel.show()
	$PauPauNoelShotgun.hide()
	$SorrisoAllie.hide()
	$SorrisoKill.hide()
	$PlayerCostas.show()
	$Panel.hide()
	$ElfoMorto.hide()
	Dialogic.signal_event.connect(_AllieCutscene)
	Dialogic.signal_event.connect(_KillCutscene)
	Dialogic.signal_event.connect(_KilledCutscene)
	if Global.KillCount < 4:
		Dialogic.start("BadEnd")
	elif Global.KillCount >= 4:
		Dialogic.start("NeutralEnd")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _AllieCutscene(argument: String):
	if argument == "Allie":
		animation.play("AllieCutscene")
		

func _KillCutscene(argument: String):
	if argument == "Enemy":
		animation.play("KillCutscene")

func _KilledCutscene(argument: String):
	if argument == "GunOut":
		$PauPauNoel.hide()
		$ShotgnReload.play()
		$PauPauNoelShotgun.show()
	if argument == "Die":
		animation.play("KilledCutscene")
