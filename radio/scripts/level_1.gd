extends Node2D

@export var boss: Node2D
@export var chave: PackedScene

func _ready() -> void:
	# Conecta o evento de morte do Boss para dropar a chave
	if boss != null:
		boss.boss_died.connect(_on_boss_died)
		
	MusicManager.play_music(preload('res://musicas/marie.mp3'))

func _on_boss_died() -> void:
	# Instancia a chave no ponto focal de câmera definido
	if chave != null:
		var inst_chave = chave.instantiate()
		add_child(inst_chave)
		inst_chave.global_position = $CameraPoint.global_position
