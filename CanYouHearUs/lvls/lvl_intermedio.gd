extends Node3D

var texto : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.historia == 4:
		$Texto/MiAmigaSePerdio.start()
	elif Globals.historia >= 5:
		$Texto.hide()
	if Globals.historia >= 6:
		$Adornos/Puerta1.NecesitoLlave = false
		$Adornos/Puerta2.NecesitoLlave = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $Texto.visible and Globals.historia == 5 and Input.is_action_just_pressed("Clickear") and texto ==1:
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "HELP_ANSWERD_1"
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "HELP_ANSWERD_2"
		$Acciones_mic.show()
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "LINE_MISSING_GIRL_2" #instrucciones de juego para hablar
		$Texto/AnimationPlayer.play("Texto")
		texto += 1
		#$Texto.hide()
	elif $Texto.visible and Globals.historia == 5 and Input.is_action_just_pressed("Clickear") and texto == 3:
		$Texto.hide()
		


func _on_mi_amiga_se_perdio_timeout():
	Globals.historia = 5
	$Texto.show()
	$Texto/Label.text = "LINE_MISSING_GIRL_1" #Se perdio mi amiga
	$Texto/AnimationPlayer.play("Texto")
	texto += 1


func _on_acciones_mic_accion_1_completada():
	$Acciones_mic.hide()
	$Texto/Label.visible_ratio = 0
	$Texto/Label.text = "LINE_MISSING_GIRL_3" #No parece haber señales, deberia seguir adelante
	$Texto/AnimationPlayer.play("Texto")
	texto += 1
	


func _on_base_puzzle_04_01_victoria_puzzle_4():
	$Adornos/Puerta1.NecesitoLlave = false
	$Adornos/Puerta2.NecesitoLlave = false
	$Adornos/Puerta1.soyPortal = true
	$Adornos/Puerta2.soyPortal = true
	Globals.historia = 6

