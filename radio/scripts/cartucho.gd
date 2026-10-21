extends RigidBody2D

func _ready() -> void:
	gravity_scale = 0


func _on_maquina_body_entered(body: Node2D) -> void:
	queue_free()
