extends ProgressBar

@export var boss: Node2D # Arraste o nó do Boss para este campo no Inspector

func _ready() -> void:
	if boss != null:
		# Define os valores iniciais
		max_value = boss.max_health
		value = boss.current_health
		
		# Conecta aos sinais do Boss
		boss.health_changed.connect(_on_boss_health_changed)
		boss.boss_died.connect(_on_boss_died)
	else:
		visible = false # Esconde a barra caso o boss não esteja na cena

func _on_boss_health_changed(current_health: float, _max_health: float) -> void:
	# Animação suave para a barra descer deslizando em 0.3 segundos
	var tween = create_tween()
	tween.tween_property(self, "value", current_health, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_boss_died() -> void:
	# Opcional: oculta a barra de vida após a morte do boss
	visible = false
