extends Node2D

@onready var timer2: Timer = $Timer2
var fim=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer2.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_2_timeout() -> void:
	fim=true
