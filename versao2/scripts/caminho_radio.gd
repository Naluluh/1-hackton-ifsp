extends PathFollow2D

@export var speed: float = 200.0
@export var is_moving: bool = true

func _process(delta: float) -> void:
	if is_moving:
		# Incrementa a posição ao longo do caminho em pixels por segundo
		progress += speed * delta
