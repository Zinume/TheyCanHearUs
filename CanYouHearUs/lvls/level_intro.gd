extends Node3D

signal Texto_4  

const setearTextoPregunta ={
	3:"QUESTION_INTRO_1"
	}


var dialogos_intro =[
	'INTRO_LINE_1',
	'INTRO_LINE_2',
	'INTRO_LINE_3',
	'INTRO_LINE_4',
	'INTRO_LINE_5',
	'INTRO_LINE_6' #deberia usar mi linterna
]
var final_de_dialogos = [
	1,
	4,
	5
]



var historia_intro : bool = false

var conversacion : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.historia == 0:
		$NuevaArea.queue_free()
	elif Globals.historia == 1:
		$NuevaArea.queue_free()
		
	if Globals.historia == 2:
		$NuevaArea.queue_free()
		$Trigger_conversacion/Area3D.global_position.z = $SubViewportContainer/SubViewport/Player.global_position.z + 10
		$Trigger_conversacion/Area3D.queue_free()
		$Rutinas_historia.play("01")
	elif Globals.historia == 3:
		$NuevaArea.queue_free()
		$Rutinas_historia.play("01")
		$Trigger_conversacion/LuzDelDia.queue_free()
		$Trigger_conversacion/Area3D.queue_free()
		await $Rutinas_historia.animation_finished
		$Rutinas_historia.play("02")
	elif Globals.historia >= 4:
		$NuevaArea.show()
		$Rutinas_historia.queue_free()
		$Personaje_00.queue_free()
		$Personaje_01.queue_free()
		$Trigger_conversacion/LuzDelDia.queue_free()
		$Trigger_conversacion/Area3D.queue_free()
		$DirectionalLight3D.light_energy = 0.3
		$DirectionalLight3D.light_color = Color(0.70,0.55,0.55)
		$Trigger_conversacion/UsaTuLinterna.queue_free()
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
		if Globals.historia == 1:
			historia_intro = true
			conversacion = 2
			$Conversacion/Control/Label.text = dialogos_intro[conversacion]
			$AnimationPlayer.play("texto")
			$Trigger_conversacion/Area3D.queue_free()
			

func _on_button_pressed():
	Globals.historia = 2
	$Conversacion/Botones.hide()
	conversacion += 1
	$Conversacion/Control/Label.text = dialogos_intro[conversacion]
	$AnimationPlayer.play("texto")


func escena_1():
	if Globals.historia == 0:
		historia_intro = true
		$Conversacion/Control/Label.text = dialogos_intro[conversacion]
		$AnimationPlayer.play("texto")

func hablar():
	if Input.is_action_just_pressed("ui_chat") and historia_intro and $Conversacion/Control/Label.visible_ratio == 1 and !Globals.ModoInventario and !Globals.ModoOpciones and !$Conversacion/Botones.visible :
		if conversacion == 1:
			Globals.historia = 1
		
		if conversacion == 4:
			Texto_4.emit()
		
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
	if Globals.historia ==0:
		$Trigger_conversacion/Area3D.global_position.z = $SubViewportContainer/SubViewport/Player.global_position.z + 10


func _on_texto_4():
	$Rutinas_historia.play("01")


func _on_eliminar_npc_body_entered(body):
	if body.is_in_group("Npc"):
		$Personaje_00.hide()
		$Personaje_00.deboMoverme = false


func _on_luz_del_dia_body_entered(body):
	if body.is_in_group("Jugador"):
		$Rutinas_historia.play("02")
		Globals.historia = 3
		$Trigger_conversacion/LuzDelDia.queue_free()


func _on_fin_mapa_body_entered(body):
	if body.is_in_group("Jugador") and Globals.historia < 4:
		Globals.historia = 4
	transporte.call_deferred()

func transporte():
	get_tree().change_scene_to_file("res://lvls/lvl_intermedio.tscn")

func _on_usa_tu_linterna_body_entered(body):
	if body.is_in_group('Jugador'):
		historia_intro = true
		conversacion = 5
		$Conversacion/Control/Label.text = dialogos_intro[conversacion]
		$AnimationPlayer.play("texto")
		$Trigger_conversacion/UsaTuLinterna.queue_free()
