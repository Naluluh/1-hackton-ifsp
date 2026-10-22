extends Node2D

func _ready() -> void:
	if not DialogoMargaret.ja_lido:
		DialogueManager.show_dialogue_balloon(preload("res://dialogos/level2.dialogue"), 'start')
		await DialogueManager.dialogue_ended
		DialogoMargaret.ja_lido = true
	# Inicializa a trilha sonora da fase da Margaret
	
	MusicManager.play_music(preload('res://musicas/margaret.ogg'))
