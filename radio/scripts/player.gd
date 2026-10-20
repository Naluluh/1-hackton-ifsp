extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -1000.0
@export var GRAVITY = 1700.0
@export_group("Configurações da Câmera")
@export var limit_left: int = -100000
@export var limit_right: int = 100000
@export var limit_top: int = -100000
@export var limit_bottom: int = 100000

@onready var game_over_scene := preload("res://cenas/ui/game_over.tscn")

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
		velocity.y = JUMP_VELOCITY / 10

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func game_over():
	get_parent().add_child(game_over_scene.instantiate())
	queue_free()
