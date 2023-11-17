extends Node3D

var LugarMouse = "null"
var ObjetoEnMiMano = "null"
@export var NumeroLugar01 : StaticBody3D = null
@export var NumeroLugar02 : StaticBody3D = null
@export var NumeroLugar03 : StaticBody3D = null
@export var NumeroLugar04 : StaticBody3D = null
@export var NumeroLugar05 : StaticBody3D = null
@export var NumeroLugar06 : StaticBody3D = null
@export var NumeroLugar07 : StaticBody3D = null
@export var NumeroLugar08 : StaticBody3D = null

#todo funciona con strings, si necesitas uno vacio debe ser un string "null"
#las piezas se llaman pieza1, etc etc.

@export var combinacion_secreta = {
	"lugar1": "pieza1",
	"lugar2": "null",
	"lugar3": "pieza3",
	"lugar4": "pieza4",
	"lugar5": "null",
	"lugar6": "null",
	"lugar7": "pieza7",
	"lugar8": "null"
}
@export var CantidadBotonesCombinacionSecreta = 4
var nueva_combinacion ={}

var piezas_colocadas = {
	"lugar1": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar2": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar3": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar4": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar5": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar6": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar7": {"position": Vector3(0, 0, 0), "pieza": "null"},
	"lugar8": {"position": Vector3(0, 0, 0), "pieza": "null"}
}


# Called when the node enters the scene tree for the first time.
func _ready():
	SiHayAreasValidadasSeAgregaSuPosicion()
	DisminuirListaDeBotonesEnElDiccionario()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(LugarMouse)
	#print(piezas_colocadas)
	#verificarVictoria()
	pass



func agregarPieza(lugar: String, pieza: String):
	if lugar in piezas_colocadas:
		piezas_colocadas[lugar]["pieza"] = pieza
		
	else:
		print("La clave ", lugar, " no existe en el diccionario piezas_colocadassss.")



func liberarZona(valor_a_quitar: String):
	# Recorre todas las claves en objetos_en_zonas
	for zona_nombre in piezas_colocadas.keys():
		# Verifica si la zona está ocupada por un objeto
		if piezas_colocadas[zona_nombre]["pieza"] == "null":
			print("La zona ", zona_nombre, " ya está vacía")
		# Verifica si el valor a quitar coincide con el valor en la zona
		elif piezas_colocadas[zona_nombre]["pieza"] == valor_a_quitar:
			# Libera la zona asignando un valor nulo
			piezas_colocadas[zona_nombre]["pieza"] = "null"
			print("Se liberó la zona ", zona_nombre)
	# Si no se encontró ninguna coincidencia, muestra un mensaje
	print("No se encontraron zonas con el valor a quitar.")


func verificarVictoria():
	var aciertos = 0
	
	for lugar in nueva_combinacion.keys():
		if piezas_colocadas.has(lugar) and piezas_colocadas[lugar]["pieza"] == nueva_combinacion[lugar]:
			aciertos += 1
	
	if aciertos == len(nueva_combinacion):
		print("¡Has ganado!")
	else:
		print("Aún no es la combinación correcta.")


func DisminuirListaDeBotonesEnElDiccionario():
	for i in range(1, CantidadBotonesCombinacionSecreta + 1):
		var boton_nombre = "lugar" + str(i)
		nueva_combinacion[boton_nombre] = combinacion_secreta[boton_nombre]
	

func SiHayAreasValidadasSeAgregaSuPosicion():
	if is_instance_valid(NumeroLugar01):
		piezas_colocadas["lugar1"]["position"] = NumeroLugar01.global_position
	if is_instance_valid(NumeroLugar02):
		piezas_colocadas["lugar2"]["position"] = NumeroLugar02.global_position
	if is_instance_valid(NumeroLugar03):
		piezas_colocadas["lugar3"]["position"] = NumeroLugar03.global_position
	if is_instance_valid(NumeroLugar04):
		piezas_colocadas["lugar4"]["position"] = NumeroLugar04.global_position
	if is_instance_valid(NumeroLugar05):
		piezas_colocadas["lugar5"]["position"] = NumeroLugar05.global_position
	if is_instance_valid(NumeroLugar06):
		piezas_colocadas["lugar6"]["position"] = NumeroLugar06.global_position
	if is_instance_valid(NumeroLugar07):
		piezas_colocadas["lugar7"]["position"] = NumeroLugar07.global_position
	if is_instance_valid(NumeroLugar08):
		piezas_colocadas["lugar8"]["position"] = NumeroLugar08.global_position


func printPieza():
	# Itera sobre el diccionario
	for lugar in piezas_colocadas.keys():
		# Verifica si la pieza no es "null"
		if piezas_colocadas[lugar]["pieza"] != "null":
			# Imprime el valor de la pieza
			print("Pieza en", lugar, ":", piezas_colocadas[lugar]["pieza"])
