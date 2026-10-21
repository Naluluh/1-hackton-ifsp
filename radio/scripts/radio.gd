extends CharacterBody2D

# Puxa o nó da bala diretamente da cena do Nível (ajusta o caminho se necessário)
@onready var bullet_scene := preload("res://cenas/objs/bala.tscn")

@export var fire_rate := 0.7
@export var bullet_speed: float = 800.0
var shoot_timer := 0.0

# Sinal emitido ao alterar a vida
signal health_changed(current_health: float, max_health: float)
signal boss_died

@export var max_health: float = 200.0
var current_health: float

func _ready() -> void:
	current_health = max_health

func take_damage(amount: float) -> void:
	current_health = max(0.0, current_health - amount)
	
	# Notifica a interface sobre a mudança
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		boss_died.emit()
		queue_free()

func _process(delta: float) -> void:
	shoot_timer += delta
	
	if shoot_timer >= fire_rate:
		shoot_timer = 0.0
		shoot_at_player()

func shoot_at_player() -> void:
	var bullet_node = bullet_scene.instantiate()
	var player = get_tree().get_first_node_in_group("player")
	if not player or not is_instance_valid(bullet_node):
		return
	
	get_tree().current_scene.add_child(bullet_node)
	var predicted_position = player.global_position
	var dir = (predicted_position - global_position).normalized()
	bullet_node.fire(global_position, dir, bullet_speed)
