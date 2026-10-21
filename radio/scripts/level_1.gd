extends Node2D

@export var boss: Node2D
@export var chave: PackedScene
func _ready() -> void:
	if boss != null:
		# Define os valores iniciais
		
		# Conecta aos sinais do Boss
		boss.boss_died.connect(_on_boss_died)
func _on_boss_died() -> void:
	var inst_chave = chave.instantiate()
	add_child(inst_chave)
	inst_chave.global_position = $CameraPoint.global_position
