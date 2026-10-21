extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player') and not get_tree().get_nodes_in_group('enemy'):
		get_tree().change_scene_to_file("res://cenas/ui/menu_selecao.tscn")
