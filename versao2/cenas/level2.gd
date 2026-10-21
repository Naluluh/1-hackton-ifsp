extends Node2D

@onready var troca_cena: Area2D = $troca_cena

func _ready() -> void:
	Gerenciador.troca_cena.connect(Callable(self, "_on_prox_cena"))
	Transição.fim_transição.connect(Callable(self, "_on_fim_transição"))
	
	
func _on_prox_cena():
	Transição._transição()

func _on_fim_transição():
	get_tree().change_scene_to_file("res://cutscenes/cenas/cutscene_estagiario.tscn")
