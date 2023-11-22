extends Node

var AcaboDeCargar = false

#logica puzzle
var DeseoVolverAlLevel = false
var PickPuzzle = false

#variable para los Pick_item
var PickieUnObjecto = false

#variable para los observation_item
var PickieUnObItem = false

#variable para los textos/pistas
var PickiUnTexto = false

var NombreProta = 'Heroe'
var ModoPlay = true
var ModoOpciones = false
var CualCategoria = false

var ModoPuzzles = false
var ModoChat = false
var ModoInventario = false

#opciones de volumen
var opcionesParametros = {
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
#opciones de pantalla
# Guardar el tamaño de ventana actual
var window_size = Vector2()
# Guardar el estado de pantalla completa
var is_fullscreen = false
var FullScreen = false

#volver a posicion despues de un puzzle
var JugadorPosAnterior = Vector3(0,0,0)
var JugueUnPuzzleYQuieroSalir = false

#portales
var JugadorPosNuevaPortal = Vector3(0,0,0)
var VengoDeUnPortal = false

var npc_historias = {
	"npc01":0,
	"npc02":0,
	"npc03":0,
	"npc04":0,
}


#variables historia y juego
var historia = 0
var puzzles = {
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
var infoJugador = {
	
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



func _toggle_fullscreen():
	if is_fullscreen:
		# Salir del modo de pantalla completa
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
		# Restaurar el tamaño de ventana original
		get_window().set_size(window_size)
		is_fullscreen = false
	else:
		# Guardar el tamaño de ventana actual antes de cambiar a pantalla completa
		window_size = get_window().get_size()
		# Entrar en modo de pantalla completa
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
		is_fullscreen = true

# Manejar la entrada de teclado no gestionada
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("fullscreen"):
			# Verificar si se presionó Alt+Enter
			_toggle_fullscreen()


func CheckFullscreen():
	#Checkear si hay fullscreen guardado
	if is_fullscreen:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (false) else Window.MODE_WINDOWED
		get_window().set_size(window_size)
	# Obtener el tamaño de ventana actual
	window_size = get_window().get_size()
	
	

#Donde se guardan los datos: C:\Users\Dave\AppData\Roaming\Godot\app_userdata\Escape Room

func guardar():
	var datos = {}
	datos["valor1"] = historia
	datos["valor2"] = puzzles
	datos["valor3"] = infoJugador
	datos["valor4"] = opcionesParametros
	datos["valor67"] = window_size
	var archivo = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	if archivo != null and archivo.is_open():
		archivo.store_var(datos)
		archivo.close()
		print('Juego guardado en: user://save_game.dat')
	else:
		print('Error al abrir el archivo para guardar los datos.')


func cargar():
	var archivo = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if FileAccess.file_exists("user://save_game.dat"):
		if archivo != null and archivo.is_open():
			var datos = archivo.get_var()
			archivo.close()
			if datos != null and datos is Dictionary:
				historia = datos["valor1"]
				puzzles = datos["valor2"]
				infoJugador = datos["valor3"]
				opcionesParametros = datos["valor4"]
				window_size = datos["valor67"]
				
				
				
	elif !FileAccess.file_exists("user://save.res"):
		print('Archivo no existe')
