extends Node2D

# Arraste o arquivo Asteroide.tscn para este campo no Inspector
@export var asteroide_scene: PackedScene

@onready var timer: Timer = $Timer

func _ready() -> void:
	# Conecta o sinal de tempo do Timer
	timer.timeout.connect(_spawnar_asteroide)

func _spawnar_asteroide() -> void:
	if asteroide_scene == null:
		return

	var asteroide = asteroide_scene.instantiate()
	var largura_tela = get_viewport_rect().size.x
	
	# Sorteia uma posição horizontal (X) dentro da largura da tela
	var x_aleatorio = randf_range(20.0, largura_tela - 20.0)
	
	# Posiciona o asteroide logo acima do topo visível da tela (Y = -40)
	asteroide.global_position = Vector2(x_aleatorio, -40.0)
	
	# Adiciona o asteroide à cena principal
	get_tree().current_scene.add_child(asteroide)
