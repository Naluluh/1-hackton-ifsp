extends Node2D

@onready var dialogo = preload("res://dialogos/level3.dialogue")

func _ready() -> void:
	# Toca a música da fase e inicia o diálogo
	MusicManager.play_music(preload("res://musicas/ada.mp3"))
	DialogueManager.show_dialogue_balloon(dialogo, 'start', [self])
	
	# Aguarda a conclusão do diálogo para retornar ao menu
	await DialogueManager.dialogue_ended
	MusicManager.play_music(preload('res://musicas/menu.ogg'))
	get_tree().change_scene_to_file('res://cenas/ui/menu_selecao.tscn')

# Função disparada de dentro do arquivo .dialogue via comando: do dropar_cartucho("NomeDoCartucho")
func dropar_cartucho(nome_cartucho: String) -> void:
	var cartucho = find_child(nome_cartucho) as RigidBody2D
	if cartucho != null:
		# Ativa a gravidade para fazer o cartucho cair
		cartucho.gravity_scale = 1.0
