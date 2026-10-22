extends Node
var audio_player: AudioStreamPlayer

func _ready() -> void:
	# Cria o nó de áudio programmaticamente
	audio_player = AudioStreamPlayer.new()
	# Define o canal de áudio como "Music" (opcional, para menus de opções)
	audio_player.bus = "Master"
	add_child(audio_player)

# Toca uma nova música ou mantém a atual se já estiver tocando
func play_music(stream: AudioStream) -> void:
	# Se já estiver tocando exatamente a mesma música, não faz nada (evita reiniciar do zero)
	if audio_player.stream == stream and audio_player.playing:
		return
	
	audio_player.stream = stream
	audio_player.play()

func stop_music() -> void:
	audio_player.stop()
