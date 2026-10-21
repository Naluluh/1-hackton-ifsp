
# Tempo para acertar a tecla: 0,25 segundo antes ou depois.
const MARGEM_ACERTO = 0.25

# Sequência de comandos da missão.
var comandos = [
	{"tecla": KEY_LEFT, "nome": "ESQUERDA", "tempo": 2.0},
	{"tecla": KEY_UP, "nome": "CIMA", "tempo": 3.0},
	{"tecla": KEY_RIGHT, "nome": "DIREITA", "tempo": 4.0},
	{"tecla": KEY_UP, "nome": "CIMA", "tempo": 5.0},
	{"tecla": KEY_LEFT, "nome": "ESQUERDA", "tempo": 6.0}
]

var tempo_decorrido = 0.0
var indice_comando = 0
var seguranca = 100
var jogo_terminado = false


func _ready():
	atualizar_interface()


func _process(delta):
	if jogo_terminado:
		return

	# Faz o cronômetro avançar.
	tempo_decorrido += delta

	# Se o jogador demorou demais, registra um erro.
	if indice_comando < comandos.size():
		var comando = comandos[indice_comando]

		if tempo_decorrido > comando["tempo"] + MARGEM_ACERTO:
			registrar_erro()

	# Atualiza o tempo na tela.
	$Tempo.text = "Tempo: %.1f s" % tempo_decorrido


func _input(event):
	if jogo_terminado:
		return

	# Detecta somente quando uma tecla é pressionada.
	if not event is InputEventKey:
		return

	if not event.pressed or event.echo:
		return

	verificar_comando(event.keycode)


func verificar_comando(tecla):
	if indice_comando >= comandos.size():
		return

	var comando = comandos[indice_comando]

	# Verifica se a tecla está correta.
	if tecla != comando["tecla"]:
		return

	# Verifica se foi pressionada no momento correto.
	var diferenca = abs(tempo_decorrido - comando["tempo"])

	if diferenca <= MARGEM_ACERTO:
		# Acerto!
		seguranca = min(seguranca + 10, 100)
		indice_comando += 1

		atualizar_interface()

		# Todos os comandos foram executados.
		if indice_comando >= comandos.size():
			finalizar_jogo(true)

	elif tempo_decorrido < comando["tempo"] - MARGEM_ACERTO:
		# O jogador apertou a tecla cedo demais.
		return


func registrar_erro():
	seguranca -= 20
	indice_comando += 1

	atualizar_interface()

	if seguranca <= 0:
		finalizar_jogo(false)
	elif indice_comando >= comandos.size():
		finalizar_jogo(false)


func atualizar_interface():
	$Seguranca.value = seguranca

	if indice_comando < comandos.size():
		var comando = comandos[indice_comando]
		$TeclaAtual.text = "Comando: " + comando["nome"]
	else:
		$TeclaAtual.text = "Sequência concluída"


func finalizar_jogo(sucesso):
	jogo_terminado = true

	if sucesso and seguranca > 0:
		$Resultado.text = "POUSO BEM-SUCEDIDO!\nApollo 11 chegou à Lua."
	else:
		$Resultado.text = "MISSÃO INTERROMPIDA!\nA trajetória ficou instável."
	
	
