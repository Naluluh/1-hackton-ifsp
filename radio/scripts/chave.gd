extends Area2D

@export var speed: float = 250.0
var player: Node2D = null
var portao: Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	portao = get_tree().get_first_node_in_group("portao")

func _process(delta: float) -> void:
	if player != null:
		# Desloca a posição em direção ao jogador a uma velocidade fixa
		global_position = global_position.move_toward(player.global_position, speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		portao.find_child('AnimatedSprite2D').play('aberta')
		queue_free()
