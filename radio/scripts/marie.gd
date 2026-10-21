extends Area2D

var player_in_range: bool = true
var dialogo_visto: bool = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player') or area.get_parent().is_in_group('player'):
		player_in_range = true
		$Sprite2D2.visible = true
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group('player') or area.get_parent().is_in_group('player'):
		player_in_range = false
		$Sprite2D2.visible = false
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_accept'):
		if player_in_range:
			if not dialogo_visto:
				get_viewport().set_input_as_handled()
				DialogueManager.show_dialogue_balloon(load("res://dialogos/level1.dialogue"), "interacao_marie")
				dialogo_visto = true
			else:
				get_viewport().set_input_as_handled()
				DialogueManager.show_dialogue_balloon(load("res://dialogos/level1.dialogue"), "interacao_marie2")
