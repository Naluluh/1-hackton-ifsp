extends Area2D

@export var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO

# Define a direção do tiro e ajusta a rotação do nó
func setup(dir: Vector2) -> void:
	direction = dir.normalized()
	rotation = direction.angle()

func _process(delta: float) -> void:
	# Move o projétil na direção configurada
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	# Remove o tiro se colidir com uma superfície sólida
	if area.is_in_group('solid'):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Aplica dano ao inimigo e remove o projétil
	if body.is_in_group('enemy'):
		if body.has_method("take_damage"):
			body.take_damage(10.0)
		queue_free()