extends Node3D

var LugarMouse = ""
var PosMouse = Vector3(0,0,0)
var ObjetoEnMiMano = ""
@export var puzzle_ganador = "01"
@export var victoria= ""

var objetos_en_zonas = {
	"01": {"position": Vector3(0, 0, 0), "valor": null},
	"02": {"position": Vector3(0, 0, 0), "valor": null},
	"03": {"position": Vector3(0, 0, 0), "valor": null},
	"04": {"position": Vector3(0, 0, 0), "valor": null},
	"05": {"position": Vector3(0, 0, 0), "valor": null},
	"06": {"position": Vector3(0, 0, 0), "valor": null},
	"07": {"position": Vector3(0, 0, 0), "valor": null},
	"08": {"position": Vector3(0, 0, 0), "valor": null}
}
@export var NumeroLugar01 : StaticBody3D = null
@export var NumeroLugar02 : StaticBody3D = null
@export var NumeroLugar03 : StaticBody3D = null
@export var NumeroLugar04 : StaticBody3D = null
@export var NumeroLugar05 : StaticBody3D = null
@export var NumeroLugar06 : StaticBody3D = null
@export var NumeroLugar07 : StaticBody3D = null
@export var NumeroLugar08 : StaticBody3D = null


func _ready():
	Globals.ModoPlay = false
	SiHayAreasValidadasSeAgregaSuPosicion()


@warning_ignore("unused_parameter")
func _process(delta):
	pass
	
	
func asignarObjetoAZona(objeto_nombre: String, zona_nombre: String):
	# Verifica si zona_nombre es válido y objetos_en_zonas tiene la clave
	if zona_nombre != "" and objetos_en_zonas.has(zona_nombre):
		# Verifica si la zona está ocupada por otro objeto
		if objetos_en_zonas[zona_nombre]["valor"] != null:
			print("La zona ", zona_nombre, " ya está ocupada por", objetos_en_zonas[zona_nombre]["valor"])
			return 
		# Asigna el objeto a la zona
		objetos_en_zonas[zona_nombre]["valor"] = objeto_nombre
		print("Se asignó el objeto ", objeto_nombre, " a la zona", zona_nombre)
	else:
		print("Nombre de zona inválido o no encontrado en objetos_en_zonas.")



# Función para liberar una zona
func liberarZona(valor_a_quitar: String):
	# Recorre todas las claves en objetos_en_zonas
	for zona_nombre in objetos_en_zonas.keys():
		# Verifica si la zona está ocupada por un objeto
		if objetos_en_zonas[zona_nombre]["valor"] == null:
			print("La zona ", zona_nombre, " ya está vacía")
		# Verifica si el valor a quitar coincide con el valor en la zona
		elif objetos_en_zonas[zona_nombre]["valor"] == valor_a_quitar:
			# Libera la zona asignando un valor nulo
			objetos_en_zonas[zona_nombre]["valor"] = null
			print("Se liberó la zona ", zona_nombre)
	# Si no se encontró ninguna coincidencia, muestra un mensaje
	print("No se encontraron zonas con el valor a quitar.")




func verificarVictoria():
	# Lógica para saber si el puzzle es correcto
	var suma = ""
	for lugar in objetos_en_zonas.keys():
		var valor = objetos_en_zonas[lugar]["valor"]
		if valor != null:
			suma += str(valor)
	
	var coinciden = suma == victoria
	if coinciden:
		# Si coinciden, se busca el puzzle ganador y se vuelve true dentro del jugador
		var puzzle_key = "Puzzle" + puzzle_ganador
		if puzzle_key in Globals.puzzles:
			Globals.puzzles[puzzle_key] = true
			print("¡Has ganado!")
			print(Globals.puzzles[puzzle_key])
		else:
			print("El puzzle ganador no está definido en Globals.puzzles.")
	else:
		print("No coinciden.")
	
	return coinciden



func SiHayAreasValidadasSeAgregaSuPosicion():
	if is_instance_valid(NumeroLugar01):
		objetos_en_zonas["01"]["position"] = NumeroLugar01.global_position
	if is_instance_valid(NumeroLugar02):
		objetos_en_zonas["02"]["position"] = NumeroLugar02.global_position
	if is_instance_valid(NumeroLugar03):
		objetos_en_zonas["03"]["position"] = NumeroLugar03.global_position
	if is_instance_valid(NumeroLugar04):
		objetos_en_zonas["04"]["position"] = NumeroLugar04.global_position
	if is_instance_valid(NumeroLugar05):
		objetos_en_zonas["05"]["position"] = NumeroLugar05.global_position
	if is_instance_valid(NumeroLugar06):
		objetos_en_zonas["06"]["position"] = NumeroLugar06.global_position
	if is_instance_valid(NumeroLugar07):
		objetos_en_zonas["07"]["position"] = NumeroLugar07.global_position
	if is_instance_valid(NumeroLugar08):
		objetos_en_zonas["08"]["position"] = NumeroLugar08.global_position



func printTodoElDiccionario():
	for clave in objetos_en_zonas.keys():
		var valor = objetos_en_zonas[clave]
		print(clave, ":", valor)
