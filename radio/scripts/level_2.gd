extends Node2D

func _ready() -> void:
	# Inicializa a trilha sonora da fase da Margaret
	MusicManager.play_music(preload('res://musicas/margaret.ogg'))
