extends CanvasLayer

@export var World : WorldEnvironment
@export var jugador : CharacterBody3D
@export var Fullscreen : Button
@export var Idioma : OptionButton
@export var Save : Button
@export var Back : Button
@export var Exit : Button
@export var Brightness : HSlider
@export var Mouse_Sen : HSlider
@export var GeneralVSlider : HSlider
@export var MusicVSlider : HSlider
@export var VoiceVSlider : HSlider
@export var SfxSlider : HSlider


func _ready():
	$VBoxContainer/Idioma.select(Globals.opcionesParametros["Idioma"])
	_on_idioma_item_selected(Globals.opcionesParametros["Idioma"])
	coneccionSonido()
	checkSonidos()
	Modo_opcion_check()


func _physics_process(_delta):
	sonido()
	
	if Input.is_action_just_pressed("ui_option") and !Globals.ModoChat:
		if Globals.ModoOpciones and !Globals.PickiUnTexto:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Globals.ModoOpciones = false
			Modo_opcion_check()
		elif Globals.ModoOpciones and Globals.PickiUnTexto:
			Globals.ModoOpciones = false
			Modo_opcion_check()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Globals.ModoOpciones = true
			Modo_opcion_check()
			Globals.ModoInventario = false
	if Input.is_action_just_pressed("ui_inventario") and Globals.ModoOpciones:
		Globals.ModoOpciones = false
		Modo_opcion_check()


func Modo_opcion_check():
	if Globals.ModoOpciones:
		show()
		Fullscreen.grab_focus()
		GeneralVSlider.value = Globals.opcionesParametros["VolumenGral"]
		MusicVSlider.value = Globals.opcionesParametros["VolumenMusic"]
		VoiceVSlider.value = Globals.opcionesParametros["VolumenVoice"]
		SfxSlider.value = Globals.opcionesParametros["VolumenSFX"]
		Brightness.value =Globals.opcionesParametros["Brightness"]
		if jugador != null:
			Mouse_Sen.value = Globals.opcionesParametros["Mouse_sen"]
		
	else:
		hide()


func _on_Fullscreen_pressed():
	if Globals.FullScreen:
		Globals.FullScreen = false
	if !Globals.FullScreen:
		Globals.FullScreen = true
	Globals._toggle_fullscreen()


func _on_GeneralVSlider_value_changed(value):
	if value != -15:
		Globals.opcionesParametros["VolumenGral"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
	else:
		Globals.opcionesParametros["VolumenGral"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),-80)

func _on_MusicSlider_value_changed(value):
	if value != -15:
		Globals.opcionesParametros["VolumenMusic"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)
	else:
		Globals.opcionesParametros["VolumenMusic"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),-80)

func _on_SFXSlider_value_changed(value):
	if value != -15:
		Globals.opcionesParametros["VolumenSFX"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"),value)
	else:
		Globals.opcionesParametros["VolumenSFX"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"),-80)
	

func _on_VoiceSlider_value_changed(value):
	if value != -15:
		Globals.opcionesParametros["VolumenVoice"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"),value)
	else:
		Globals.opcionesParametros["VolumenVoice"] = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"),-80)

func _on_Back_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Globals.ModoOpciones:
		Globals.ModoOpciones = false
		Modo_opcion_check()
	else:
		Globals.ModoOpciones = true
		Modo_opcion_check()


func _on_Exit_pressed():
	Globals.ModoOpciones = false
	get_tree().change_scene_to_file("res://lvls/main_menu.tscn")
	


func _on_Save_pressed():
	Globals.window_size = get_window().get_size()
	Globals.guardar()





func _on_brightness_value_changed(value):
	Globals.opcionesParametros["Brightness"] = value
	World.environment.adjustment_brightness = value

func _on_mouse_sensitivity_value_changed(value):
	Globals.opcionesParametros["Mouse_sen"] = value
	jugador.mouse_sensitivity = value
	jugador.mouseSen()



func checkSonidos():
	if jugador != null:
		jugador.mouse_sensitivity = Globals.opcionesParametros["Mouse_sen"]
		jugador.mouseSen()
		
	if Globals.opcionesParametros["VolumenGral"] != -15:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),Globals.opcionesParametros["VolumenGral"])
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),-80)
		
	if Globals.opcionesParametros["VolumenMusic"] != -15:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),Globals.opcionesParametros["VolumenMusic"])
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),-80)
	
	if Globals.opcionesParametros["VolumenSFX"] != -15:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"),Globals.opcionesParametros["VolumenSFX"])
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FX"),-80)
	
	if Globals.opcionesParametros["VolumenVoice"] != -15:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"),Globals.opcionesParametros["VolumenVoice"])
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"),-80)
	

func sonido():
	if Globals.ModoOpciones:
		if Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right")||Input.is_action_just_pressed("ui_up")||Input.is_action_just_pressed("ui_down") :
			$Click.play()
		


func coneccionSonido():
	Fullscreen.mouse_entered.connect(sonidoClick)
	Idioma.mouse_entered.connect(sonidoClick)
	Save.mouse_entered.connect(sonidoClick)
	Back.mouse_entered.connect(sonidoClick)
	Exit.mouse_entered.connect(sonidoClick)
	Brightness.mouse_entered.connect(sonidoClick)
	Mouse_Sen.mouse_entered.connect(sonidoClick)
	GeneralVSlider.mouse_entered.connect(sonidoClick)
	MusicVSlider.mouse_entered.connect(sonidoClick)
	VoiceVSlider.mouse_entered.connect(sonidoClick)
	SfxSlider.mouse_entered.connect(sonidoClick)
	
	Fullscreen.pressed.connect(sonidoClick)
	Idioma.pressed.connect(sonidoClick)
	Save.pressed.connect(sonidoClick)
	Back.pressed.connect(sonidoClick)
	Exit.pressed.connect(sonidoClick)
	
func sonidoClick():
	$Click.play()

func idioma():
	Fullscreen.text = tr("Fullscreen")

func _on_idioma_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("en")
		Globals.opcionesParametros["Idioma"] = 0
	elif index == 1:
		TranslationServer.set_locale("es")
		Globals.opcionesParametros["Idioma"] = 1
