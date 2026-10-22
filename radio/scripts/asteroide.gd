extends Area2D
@export var speed: float = 300.0

func _process(delta: float) -> void:
	# Move o asteroide continuamente para baixo
	global_position.y += speed * delta

# Conecte o sinal 'area_entered' (se a nave for Area2D) ou 'body_entered' (se for CharacterBody2D)
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") or area.get_parent().is_in_group("player"):
		print('sera q é aqui?')
		# Recarrega a fase do início ao colidir com o jogador
		area.game_over()

# Conecte o sinal 'screen_exited' do VisibleOnScreenNotifier2D
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
