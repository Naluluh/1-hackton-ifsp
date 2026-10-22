extends CanvasLayer
@onready var label_timer: Label = $TimerLabel
@onready var countdown_timer: Timer = $CountdownTimer

func _ready() -> void:
	# Conecta o sinal de finalização do Timer via código
	countdown_timer.timeout.connect(_on_timer_timeout)

func _process(_delta: float) -> void:
	# Atualiza o texto na tela com o tempo restante arredondado para cima
	var tempo_restante: float = countdown_timer.time_left
	label_timer.text = "Tempo: %ds" % ceili(tempo_restante)

func _on_timer_timeout() -> void:
	get_tree().paused = true
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# Anima o canal Alpha (transparência) do ColorRect de 0.0 até 1.0 em 1.5 segundos
	tween.tween_property($FadeRect, "color:a", 1.0, 1.5)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	set_physics_process(false)
	
	# 3. Espera o efeito de escurecimento terminar
	await tween.finished
	
	# 3. OBRIGATÓRIO: Restaura a velocidade normal ANTES de recarregar
	get_tree().paused = false
	MusicManager.play_music(preload('res://musicas/menu.ogg'))
	get_tree().change_scene_to_file("res://cenas/ui/menu_selecao.tscn")
