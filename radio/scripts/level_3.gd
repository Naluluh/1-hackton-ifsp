extends Node2D

@onready var dialogo = preload("res://dialogos/level3.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogo, 'start', [self])
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file('res://cenas/ui/menu_selecao.tscn')

func dropar_cartucho(nome_cartucho: String):
	var cartucho = find_child(nome_cartucho)
	cartucho.gravity_scale = 1
