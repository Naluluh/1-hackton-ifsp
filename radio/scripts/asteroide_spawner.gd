extends Node2D

# Cena do asteroide a ser instanciada (atribuir no Inspector)
@export var asteroide_scene: PackedScene

@onready var timer: Timer = $Timer

func _ready() -> void:
	if not DialogoMargaret.ja_lido:
		await DialogueManager.dialogue_ended
	# Conecta o sinal do Timer para criar asteroides periodicamente
	timer.timeout.connect(_spawnar_asteroide)

func _spawnar_asteroide() -> void:
	if asteroide_scene == null:
		return

	var asteroide = asteroide_scene.instantiate()
	var largura_tela = get_viewport_rect().size.x
	
	# Sorteia uma posição horizontal aleatória dentro dos limites da tela
	var x_aleatorio = randf_range(20.0, largura_tela - 20.0)
	
	# Posiciona o asteroide ligeiramente acima da borda superior visível
	asteroide.global_position = Vector2(x_aleatorio, -40.0)
	
	# Adiciona o asteroide ao nó raiz da cena ativa
	get_tree().current_scene.add_child(asteroide)
