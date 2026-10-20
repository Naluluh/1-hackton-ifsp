extends Node2D

var direction := Vector2.ZERO
var speed := 700.0
var active := false # Controla se a bala está a voar ou escondida

func _ready() -> void:
	visible = false # Esconde a bala assim que o jogo começa

func _process(delta: float) -> void:
	if not active:
		return # Não faz nada se a bala não tiver sido disparada
		
	# CORREÇÃO: Usa global_position para acompanhar o movimento global corretamente
	global_position += direction * speed * delta
	
	# Verifica colisão com o jogador
	var player = get_tree().get_first_node_in_group("player")
	if player and global_position.distance_to(player.global_position) < 25.0:
		print("O jogador foi atingido!")
		player.game_over()
		queue_free()

func fire(start_pos: Vector2, target_direction: Vector2, new_speed: float = 700.0) -> void:
	global_position = start_pos
	direction = target_direction
	active = true
	visible = true
	speed = new_speed
