extends Area2D

@export var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO

# Inicializa a direção e rotaciona o Sprite na direção certa
func setup(dir: Vector2) -> void:
	direction = dir.normalized()
	rotation = direction.angle()

func _process(delta: float) -> void:
	global_position += direction * speed * delta



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('solid'):
		queue_free()
	elif area.is_in_group('enemy'):
		pass
