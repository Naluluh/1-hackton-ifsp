extends Control


func _on_começar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/ui/menu_selecao.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
