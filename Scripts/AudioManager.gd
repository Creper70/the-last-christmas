extends Node

# Sons que persistem entre cenas
var audio_player: AudioStreamPlayer
var music_player: AudioStreamPlayer

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	# Cria o player de música de fundo
	music_player = AudioStreamPlayer.new()
	music_player.volume_db = -35.0  # Volume baixo
	add_child(music_player)
	
	# Toca a música de fundo
	var bgm = load("res://sounds/Musicadefundo.mp3")
	if bgm:
		music_player.stream = bgm
		music_player.stream.loop = true
		music_player.play()

func play_sound(sound_path: String, volume_db: float = 0.0) -> void:
	var sound = load(sound_path)
	if sound:
		audio_player.stream = sound
		audio_player.volume_db = volume_db
		audio_player.play()

func play_door_sound() -> void:
	play_sound("res://sounds/DoorOpening.mp3", 0.0)
