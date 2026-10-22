extends PathFollow2D

@export var speed: float = 200.0
@export var is_moving: bool = true

func _process(delta: float) -> void:
	if is_moving:
		# Avança a posição ao longo da curva do Path2D
		progress += speed * delta
