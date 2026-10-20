extends Area2D

var player_in_range: bool = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player') or area.get_parent().is_in_group('player'):
		player_in_range = true
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group('player') or area.get_parent().is_in_group('player'):
		player_in_range = false
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_accept'):
		print("2. Tecla ui_accept pressionada. Dentro da área? ", player_in_range)
		if player_in_range:
			get_viewport().set_input_as_handled()
			DialogueManager.show_dialogue_balloon(load("res://dialogos/level1.dialogue"), "interacao_marie")
