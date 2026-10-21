extends Control

const MARGEM_ACERTO = 0.4

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

	tempo_decorrido += delta

	$Tempo.text = "Tempo: %.1f" % tempo_decorrido

	if indice_comando >= comandos.size():
		return

	var comando = comandos[indice_comando]

	if tempo_decorrido > comando["tempo"] + MARGEM_ACERTO:
		registrar_erro()


func _input(event):
	if jogo_terminado:
		return

	if not event is InputEventKey:
		return

	if not event.pressed or event.echo:
		return

	verificar_comando(event.keycode)


func verificar_comando(tecla):
	var comando = comandos[indice_comando]

	if tecla != comando["tecla"]:
		return

	var diferenca = abs(tempo_decorrido - comando["tempo"])

	if diferenca <= MARGEM_ACERTO:
		seguranca = min(seguranca + 10, 100)
		indice_comando += 1

		atualizar_interface()

		if indice_comando >= comandos.size():
			finalizar_jogo(true)


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
		$TeclaAtual.text = comandos[indice_comando]["nome"]
	else:
		$TeclaAtual.text = "Sequência concluída"


func finalizar_jogo(sucesso):
	jogo_terminado = true

	if sucesso:
		$Resultado.text = "POUSO BEM-SUCEDIDO!"
	else:
		$Resultado.text = "MISSÃO INTERROMPIDA!"
