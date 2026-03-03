extends CharacterBody2D
class_name Player

@export var input_locked: bool = false
var can_run

@export var walk_speed = 800.0
@export var run_speed = 1000.0
@onready var Hitscan = $MouseFollow/HitScan
@onready var Shoot = $shoot
@onready var timer = $temporizador
@onready var laser_sight = $MouseFollow/HitScan/LaserSight
@onready var firstFace = load("res://Sprites/assets/NPC_ElfoFrente.png")
@onready var SmileFace = load("res://Sprites/Player/Player_SorissoFrenteIdle.png")
@onready var FinalFace = load("res://Sprites/Player/ElfoParaTeste.png")

var can_shoot = true
var is_running = false
var last_direction = Vector2(0, 1)




func _ready() -> void:
	can_run = true
	velocity = Vector2.ZERO

func _input(event):
	if input_locked:
		return

	if event.is_action_pressed("run") && can_run:
		is_running = true
	elif event.is_action_released("run"):
		is_running = false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Lock"):
		input_locked = !input_locked
	
	if input_locked:
		return
	else:
		var input_vector = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)

		if input_vector != Vector2.ZERO:
			input_vector = input_vector.normalized()
			last_direction = input_vector
			var speed = walk_speed if not is_running else run_speed
			velocity = input_vector * speed
		else:
			velocity = Vector2.ZERO
		move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and timer.is_stopped() and can_shoot == true:
		timer.start()
		Shoot.play()
		
		# Esconde o laser durante o tiro
		if laser_sight:
			laser_sight.hide()
		
		# Cria o trail visual do tiro
		var trail = Line2D.new()
		var trail_script = load("res://Scripts/bullet_trail.gd")
		trail.set_script(trail_script)
		
		var start_pos = Hitscan.global_position
		var end_pos = start_pos + Hitscan.target_position.rotated(Hitscan.global_rotation)
		
		if Hitscan.is_colliding():
			end_pos = Hitscan.get_collision_point()
			var collider = Hitscan.get_collider()
				
			if collider is Enemy:
				collider.take_hit(20)
				await get_tree().process_frame
		
		trail.add_point(start_pos)
		trail.add_point(end_pos)
		get_tree().root.add_child(trail)
		
		# Mostra o laser de volta após 0.2 segundos
		await get_tree().create_timer(0.2).timeout
		if laser_sight:
			laser_sight.show()
		
		Global.has_shooted = true
		
	
func lockPlayer():
	if input_locked == false:
		$MouseFollow/HitScan/LaserSight.hide()
		input_locked = true

func unlockPlayer():
	if input_locked == true:
		$MouseFollow/HitScan/LaserSight.show()
		input_locked = false
		timer.start()


func somtiro():
	$shoot.play()


func _change_sprite():
	$Sprite2D.set_texture(firstFace)



func _change_sprite2():
	$Sprite2D.set_texture(SmileFace)

func _change_sprite3():
	$Sprite2D.set_texture(FinalFace)
