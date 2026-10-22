extends Control


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/levels/pre_level1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/levels/pre_level2.tscn")


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/levels/pre_level3.tscn")

func _on_sair_button_up() -> void:
	get_tree().change_scene_to_file("res://cenas/ui/menu_start.tscn")
