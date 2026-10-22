extends Area2D

@export var speed: float = 500.0
@export var padding: float = 24.0 # Margem para a nave não encostar metade do corpo fora da tela
@export var fade_rect: ColorRect

func _ready() -> void:
	add_to_group("player")

func _process(delta: float) -> void:
	var direction := Vector2.ZERO

	# Captura o movimento nas 4 direções
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	# Normaliza para que a velocidade na diagonal não seja mais rápida
	if direction.length() > 0:
		direction = direction.normalized()

	# Move a posição global da nave
	global_position += direction * speed * delta
	
	var screen_size = get_viewport_rect().size

	# 3. Trava a posição X e Y dentro dos limites da tela
	global_position.x = clampf(global_position.x, padding, screen_size.x - padding)
	global_position.y = clampf(global_position.y, padding, screen_size.y - padding)
func game_over() -> void:
	get_parent().find_child('CanvasLayer').find_child('AnimatedSprite2D').play('dano')
	get_tree().paused = true
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# Anima o canal Alpha (transparência) do ColorRect de 0.0 até 1.0 em 1.5 segundos
	tween.tween_property(fade_rect, "color:a", 1.0, 1.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	set_physics_process(false)
	
	# 3. Espera o efeito de escurecimento terminar
	await tween.finished
	
	# 3. OBRIGATÓRIO: Restaura a velocidade normal ANTES de recarregar
	get_tree().paused = false
	get_tree().reload_current_scene()
