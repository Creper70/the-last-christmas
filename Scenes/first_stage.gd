extends Node2D

@onready var deadElfs = $DeadElfs
@onready var aliveElfs = $AliveElfs
@onready var animation = $AnimationPlayer
@onready var Gun = $Gun
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_Cutscene_End)
	Dialogic.signal_event.connect(_Gun_Appear)
	Dialogic.signal_event.connect(_firstSprite)
	Dialogic.signal_event.connect(_smileSprite)
	
	# Posiciona o player baseado de onde ele veio
	if Global.last_door == "from_second_back":
		# Veio voltando do second stage - coloca na frente da porta que vai pro second
		player.set_position(Vector2(1412, 561))  # Ajusta essa posição pra frente da sua porta
	
	if Global.ElfsDeads == false:
		deadElfs.set_visible(false)
		aliveElfs.set_visible(true)
		$Player.can_shoot = false
		$Player.lockPlayer()
		Dialogic.start("FirstCutscene")
	elif  Global.ElfsDeads == true:
		deadElfs.set_visible(true)
		aliveElfs.set_visible(false)
		$Player.can_shoot = true
		if Global.last_door == "":
			# Primeira vez entrando na cena
			$Player.set_position(Vector2(1412,561))
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func killElfs():
	Global.ElfsDeads = true

func _firstSprite(argument:String):
	if argument == "FirstSprite":
		player._change_sprite()

func _smileSprite(argument:String):
	if argument == "SmileSprite":
		player._change_sprite2()

func _Gun_Appear(argument:String):
	if argument == "GunAppear":
		Gun.set_visible(true)


func _Cutscene_End(argument:String):
	if argument == "End_FirstCutscene":
		animation.play("DeadTransition")
		Gun.set_visible(false)
		$Player.can_shoot = true
		$Player.somtiro()
		$Player.unlockPlayer()
		
