extends RigidBody2D

func _ready() -> void:
	# Mantém o objeto estático até a gravidade ser reativada por evento
	gravity_scale = 0.0

func _on_maquina_body_entered(_body: Node2D) -> void:
	# Destrói o item ao entrar na máquina
	queue_free()
