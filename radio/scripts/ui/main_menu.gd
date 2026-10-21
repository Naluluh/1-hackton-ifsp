extends Control

@export var fade_rect: ColorRect

func _ready() -> void:
	if fade_rect:
		# Permite que os cliques passem através do ColorRect transparente
		fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_começar_pressed() -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# Anima o canal Alpha (transparência) do ColorRect de 0.0 até 1.0 em 1.5 segundos
	tween.tween_property(fade_rect, "color:a", 1.0, 0.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	get_tree().change_scene_to_file("res://cenas/ui/menu_selecao.tscn")


func _on_sair_pressed() -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	# Anima o canal Alpha (transparência) do ColorRect de 0.0 até 1.0 em 1.5 segundos
	tween.tween_property(fade_rect, "color:a", 1.0, 1.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	# 3. OBRIGATÓRIO: Restaura a velocidade normal ANTES de recarregar
	get_tree().quit()
