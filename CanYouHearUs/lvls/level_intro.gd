extends Node3D

const setearTextoPregunta ={
	3:"QUESTION_1"
	}


var dialogos_intro =[
	'Intro_line_1',
	'Intro_line_2',
	'Intro_line_3',
	'Intro_line_4',
	'Intro_line_5'
]
var final_de_dialogos = [
	1,
	4
]

var historia_intro : bool = false

var conversacion : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	escena_1()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	posTrigger()
	chat()
	hablar()


func chat():
	if historia_intro:
		$Conversacion/Control.show()
	elif !historia_intro:
		$Conversacion/Control.hide()


func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		historia_intro = true
		conversacion += 1
		$Conversacion/Control/Label.text = dialogos_intro[conversacion]
		$AnimationPlayer.play("texto")
		$Trigger_conversacion/Area3D.queue_free()

func _on_button_pressed():
	$Conversacion/Botones.hide()
	conversacion += 1
	$Conversacion/Control/Label.text = dialogos_intro[conversacion]
	$AnimationPlayer.play("texto")


func escena_1():
	if conversacion == 0 and Globals.historia == 0:
		historia_intro = true
		$Conversacion/Control/Label.text = dialogos_intro[conversacion]
		$AnimationPlayer.play("texto")

func hablar():
	if Input.is_action_just_pressed("ui_chat") and historia_intro and Globals.historia == 0 and $Conversacion/Control/Label.visible_ratio == 1 and !Globals.ModoInventario and !Globals.ModoOpciones and !$Conversacion/Botones.visible :
		if conversacion in final_de_dialogos:
			finDeChat()
		if historia_intro == true:
			avanzarSiguienteTexto()
		if conversacion in setearTextoPregunta:
			setearBoton(setearTextoPregunta[conversacion])
		

func finDeChat():
	historia_intro = false
	$Conversacion/Control/Label.visible_ratio = 0

func avanzarSiguienteTexto():
	$Conversacion/Control/Label.visible_ratio = 0
	conversacion += 1
	$Conversacion/Control/Label.text = dialogos_intro[conversacion]
	$AnimationPlayer.play("texto")
	
func setearBoton(texto:String):
	$Conversacion/Botones.show()
	$Conversacion/Botones/Button.grab_focus()
	$Conversacion/Botones/Button.text = texto

#esta funcion es para evitar que se salten dialogos. Si el jugador ignora todo, no habra errores de todas maneras.
func posTrigger():
	if conversacion <1:
		$Trigger_conversacion/Area3D.global_position.z = $SubViewportContainer/SubViewport/Player.global_position.z + 10
