extends Node2D

@onready var dialogo = preload("res://dialogos/level3.dialogue")

func _ready() -> void:
	MusicManager.play_music(preload("res://musicas/ada.mp3"))
	DialogueManager.show_dialogue_balloon(dialogo, 'start', [self])
	await DialogueManager.dialogue_ended
	MusicManager.play_music(preload('res://musicas/menu.ogg'))
	get_tree().change_scene_to_file('res://cenas/ui/menu_selecao.tscn')

func dropar_cartucho(nome_cartucho: String):
	var cartucho = find_child(nome_cartucho)
	cartucho.gravity_scale = 1
