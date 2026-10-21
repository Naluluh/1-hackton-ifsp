extends CharacterBody2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
const SPEED = 150.0
var dano:=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var gameover=false
var delta2
@onready var timer2: Timer = $Timer2

func _ready() -> void:
	Gerenciador.kill.connect(Callable(self, "_on_kill"))
	animated_sprite_2d.animation_finished.connect(Callable(self, "_on_animation_finished"))
	Gerenciador.morte.connect(Callable(self, "_on_morte"))
	
func _physics_process(delta: float) -> void:
	delta2=delta
	if gameover==false:
		var directionx := Input.get_axis("left", "right")
		if directionx:
			velocity.x = directionx * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		var directiony := Input.get_axis("up", "down")
		if directiony:
			velocity.y = directiony * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()

func _on_kill():
	print("Health: ", Gerenciador.health)
	if dano==false:
		animated_sprite_2d.play("dano")
		collision_shape.disabled = true
		print("Colisao kill desativada")
		timer.start()
		dano = true
		print("Dano true")
		Gerenciador.health -= 1
		print("Health: ", Gerenciador.health)
			
				
			

func _on_timer_timeout() -> void:
	collision_shape.disabled = false
	print("Colisao kill ativada")
	dano=false
	print("Dano false")

func _on_morte():
	collision_shape.disabled = true
	print("Colisao desativada")
	gameover=true
	animated_sprite_2d.play("queda")
	
func _on_animation_finished() -> void:
	# Lógica de dano
		if Gerenciador.health > 0 and Gerenciador.health == 1:
			animated_sprite_2d.play("quebrado")
		else:
			animated_sprite_2d.play("default")
				
		if Gerenciador.health <= 0:
			Gerenciador.morte.emit()
	
		if animated_sprite_2d.animation == "queda":
			collision_shape.disabled = true
			print("Colisao desativada")
			start_fall()

func start_fall() -> void:
	timer2.start()
	
	
	

	

func _on_timer_2_timeout() -> void:
	var tween = create_tween()
	audio_stream_player_2d.playing = true
	tween.tween_property(self, "position", position + Vector2(0, 320), 2)
	if position.y>=200:
		#Transição._transição()
		#await Transição.fim_transição
		Gerenciador.troca_cena.emit()
