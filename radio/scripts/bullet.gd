extends Area2D

var direction := Vector2.ZERO
var speed := 700.0
var active := false # Controla se o projétil está ativo no mapa

func _ready() -> void:
	visible = false # Inicia oculto até ser disparado

func _process(delta: float) -> void:
	if not active:
		return
		
	# Atualiza a posição no espaço global
	global_position += direction * speed * delta

# Dispara o projétil definindo posição, direção e animação
func fire(start_pos: Vector2, target_direction: Vector2, new_speed: float = 700.0) -> void:
	global_position = start_pos
	direction = target_direction
	speed = new_speed
	active = true
	visible = true
	$AnimatedSprite2D.play('default')

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		# Aciona o Game Over no nó pai do jogador
		area.get_parent().game_over()
	elif area.is_in_group('solid'):
		# Destrói o projétil ao atingir paredes ou obstáculos
		queue_free()
