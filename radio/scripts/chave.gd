extends Area2D

@export var speed: float = 250.0

var player: Node2D = null
var portao: Node2D = null

func _ready() -> void:
	# Localiza as referências do jogador e do portão no mapa
	player = get_tree().get_first_node_in_group("player")
	portao = get_tree().get_first_node_in_group("portao")

func _process(delta: float) -> void:
	if player != null:
		# Persegue a posição do jogador suavemente
		global_position = global_position.move_toward(player.global_position, speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		# Abre o portão e consome o item
		if portao != null:
			var sprite = portao.find_child('AnimatedSprite2D')
			if sprite:
				sprite.play('aberta')
		queue_free()
