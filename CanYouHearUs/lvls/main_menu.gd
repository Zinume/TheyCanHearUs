extends Node3D

var BorrarPartida = false
var NivelInicial = "res://lvls/level_intro.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	print('aca')


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	visibilidadBorrarPartida()
	
	
func _on_button_pressed():
	if FileAccess.file_exists("user://save_game.dat"): 
		BorrarPartida = true
	else:
		variablesAResetear()
		get_tree().change_scene_to_file(NivelInicial)


func _on_button_2_pressed():
	if FileAccess.file_exists("user://save_game.dat"): 
		Globals.AcaboDeCargar = true
		Globals.cargar()
		get_tree().change_scene_to_file(Globals.infoJugador["escenaACargar"])


func _on_button_3_pressed():
	Globals.ModoOpciones = true
	$UI_Opciones.Modo_opcion_check()


func _on_button_4_pressed():
	get_tree().quit()


func _on_si_pressed():
	DirAccess.remove_absolute("user://save_game.dat")
	variablesAResetear()
	get_tree().change_scene_to_file(NivelInicial)


func _on_no_pressed():
	BorrarPartida = false


func visibilidadBorrarPartida():
	if BorrarPartida:
		$BorrarPartida.show()
	else:
		$BorrarPartida.hide()


func visibilidadMouse():
	if Globals.ModoOpciones:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		


func variablesAResetear():
	Globals.opcionesParametros = {
	"MicSen":10,
	"ValorMic":0,
	"Idioma":0,
	"VolumenGral":-3,
	"VolumenVoice":-3,
	"VolumenMusic":-3,
	"VolumenSFX":-3,
	"Mouse_sen":2,
	"Brightness":1,
	}
	Globals.historia = 0
	Globals.puzzles = {
		"Puzzle01": false,
		"Puzzle02": false,
		"Puzzle03": false,
		"Puzzle04": false,
		"Puzzle05": false,
		"Puzzle06": false,
		"Puzzle07": false,
		"Puzzle08": false,
		"Puzzle09": false,
		"Puzzle10": false
	}
	Globals.infoJugador = {
		"Linterna": false,
		"posicion": Vector3(0,0,0),
		"rotacion": Vector3(0,0,0),
		"escenaACargar": "res://lvls/level_1.tscn",
		"inventario":{
			"item1": false,
			"item2": false,
			"item3": false,
			"item4": false,
			"item5": false,
			"diario1": false,
			"diario2": false,
			"diario3": false,
			"diario4": false,
			"diario5": false,
		}
	}


func _on_ui_opciones_sali_de_opciones():
	visibilidadMouse()
