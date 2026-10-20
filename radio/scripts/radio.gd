extends CharacterBody2D

# Puxa o nó da bala diretamente da cena do Nível (ajusta o caminho se necessário)
@onready var bullet_scene := preload("res://cenas/objs/bala.tscn")

@export var fire_rate := 0.8
var shoot_timer := 0.0

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
	
	get_parent().add_child(bullet_node)
	# Previsão de mira (Modo Difícil)
	var player_velocity = player.velocity if "velocity" in player else Vector2.ZERO
	var distance = global_position.distance_to(player.global_position)
	var bullet_speed = 700.0
	
	var time_to_target = distance / bullet_speed
	var predicted_position = player.global_position + (player_velocity * time_to_target)
	var dir = (predicted_position - global_position).normalized()
	
	# Ativa e dispara a bala que está no nível
	bullet_node.fire(global_position, dir)
