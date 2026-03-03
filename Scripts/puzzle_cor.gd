extends CanvasLayer

@onready var Vermelho = $vermelho
@onready var Amarelo = $amarelo
@onready var verde = $verde
@onready var azul = $azul
@onready var lilas = $lilas
@onready var rosa = $rosa
@onready var preto = $preto
@onready var bege = $bege
@onready var branco = $branco

@onready var ClickButton = $ButtonClick
@onready var ErrorSound = $ErrorSound

# Coloca aqui a sequência correta (muda pra ordem que tu quiser)
var correct_sequence = ["amarelo", "vermelho", "azul", "branco"]

# Array que vai guardando as cores que o player aperta
var player_sequence = []

func _ready() -> void:
	pass

func check_sequence(color_name: String) -> void:
	# Adiciona a cor que foi apertada
	player_sequence.append(color_name)
	print("Apertou: ", color_name)
	print("Sequência atual: ", player_sequence)
	
	# Verifica se tá certo até agora
	var is_correct = true
	for i in range(player_sequence.size()):
		if player_sequence[i] != correct_sequence[i]:
			is_correct = false
			break
	
	# Se errou, reseta
	if not is_correct:
		print("ERROU! Resetando...")
		ErrorSound.play()
		player_sequence.clear()
		return
	
	# Se acertou tudo, puzzle resolvido
	if player_sequence.size() == correct_sequence.size():
		Global.puzzle_resolvido = true
		self.hide()
		print("PUZZLE RESOLVIDO!")
		# Aqui você abre a porta
		# Exemplo: get_node("../Porta").unlock()

#region botoes
func _on_vermelho_pressed() -> void:
	check_sequence("vermelho")
	ClickButton.play()

func _on_amarelo_pressed() -> void:
	check_sequence("amarelo")
	ClickButton.play()

func _on_verde_pressed() -> void:
	check_sequence("verde")
	ClickButton.play()

func _on_azul_pressed() -> void:
	check_sequence("azul")
	ClickButton.play()

func _on_lilas_pressed() -> void:
	check_sequence("lilas")
	ClickButton.play()

func _on_rosa_pressed() -> void:
	check_sequence("rosa")
	ClickButton.play()

func _on_preto_pressed() -> void:
	check_sequence("preto")
	ClickButton.play()

func _on_bege_pressed() -> void:
	check_sequence("bege")
	ClickButton.play()

func _on_branco_pressed() -> void:
	check_sequence("branco")
	ClickButton.play()

#endregion


func _on_back_button_pressed() -> void:
	self.hide()
	
