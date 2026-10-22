extends Node2D

@export var fade_rect: ColorRect

func _ready() -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_começar_button_down() -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# Anima o canal Alpha (transparência) do ColorRect de 0.0 até 1.0 em 1.5 segundos
	tween.tween_property(fade_rect, "color:a", 1.0, 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	get_tree().change_scene_to_file("res://cenas/levels/level2.tscn")
