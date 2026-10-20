extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -1000.0
const GRAVITY = 1700.0
const BALA_SCENE = preload("res://cenas/objs/bala_player.tscn")

@export_group("Configurações da Câmera")
@export var limit_left: int = -100000
@export var limit_right: int = 100000
@export var limit_top: int = -100000
@export var limit_bottom: int = 100000

@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	camera_2d.limit_left = limit_left
	camera_2d.limit_right = limit_right
	camera_2d.limit_top = limit_top
	camera_2d.limit_bottom = limit_bottom

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("pular") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 100

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("andar_esquerda", "andar_direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func game_over():
	Engine.time_scale = 0.0
	
	# 2. Espera 1 segundo em tempo real (o último argumento 'true' ignora a time_scale)
	await get_tree().create_timer(0.5, true, false, true).timeout
	
	# 3. OBRIGATÓRIO: Restaura a velocidade normal ANTES de recarregar
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
	var shoot_dir := Vector2.ZERO
	if event.is_action_pressed("atirar_cima"):
		shoot_dir = Vector2.UP
	elif event.is_action_pressed("atirar_baixo"):
		shoot_dir = Vector2.DOWN
	elif event.is_action_pressed("atirar_esquerda"):
		shoot_dir = Vector2.LEFT
	elif event.is_action_pressed("atirar_direita"):
		shoot_dir = Vector2.RIGHT
	if shoot_dir != Vector2.ZERO:
		atirar(shoot_dir)

func atirar(direcao: Vector2) -> void:
	var bala = BALA_SCENE.instantiate()
	
	# Adiciona a bala na cena principal (mundo) para não ficar presa ao jogador
	get_tree().current_scene.add_child(bala)
	
	# Define a posição inicial e a direção
	bala.global_position = global_position
	bala.setup(direcao)
