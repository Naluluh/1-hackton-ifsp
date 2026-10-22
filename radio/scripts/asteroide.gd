extends Area2D

@export var speed: float = 700.0

func _ready() -> void:
	$Sprite2D.play('default')

func _process(delta: float) -> void:
	# Move o asteroide continuamente para baixo
	global_position.y += speed * delta

func _on_area_entered(area: Area2D) -> void:
	# Verifica se colidiu diretamente com o jogador ou com um nó filho dele
	if area.is_in_group("player") or area.get_parent().is_in_group("player"):
		# Aciona a rotina de Game Over do jogador
		area.game_over()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Libera o asteroide da memória ao sair da tela
	queue_free()
