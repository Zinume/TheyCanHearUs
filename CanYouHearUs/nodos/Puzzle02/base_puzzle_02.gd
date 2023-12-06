extends Node3D

signal victoriaPuzzle2

@export var puzzle_ganador = "01"
@export var JugadorSeQuedaQuieto = false

# Define la combinación secreta de botones
@export var combinacion_secreta = {
	"boton1": false,
	"boton2": false,
	"boton3": false,
	"boton4": false,
	"boton5": false,
	"boton6": false,
	"boton7": false,
	"boton8": false
}

@export var CantidadBotonesCombinacionSecreta = 2

#estos son los resultados de los botones
var botones = {
	"boton1": false,
	"boton2": false,
	"boton3": false,
	"boton4": false,
	"boton5": false,
	"boton6": false,
	"boton7": false,
	"boton8": false
}
#esta variable se crea en ready basado en el numero numero de Cantidad de Botones Combinacion Secreta
var nuevobotones ={}


#hijos Botones
@export var boton1 = Node3D
@export var boton2 = Node3D
@export var boton3 = Node3D
@export var boton4 = Node3D
@export var boton5 = Node3D
@export var boton6 = Node3D
@export var boton7 = Node3D
@export var boton8 = Node3D


func _ready():
	if JugadorSeQuedaQuieto:
		Globals.ModoPlay = false
	DisminuirListaDeBotonesEnElDiccionario()
	

func _process(_delta):
	pass
	#verificarCombinacion()


func verificarCombinacion():
	var aciertos = 0
	
	for boton in combinacion_secreta.keys():
		if boton in nuevobotones and combinacion_secreta[boton] == nuevobotones[boton]:
			aciertos += 1
		else:
			break  # Si encuentra una discrepancia, sale del bucle
				
	if aciertos == CantidadBotonesCombinacionSecreta:
		print("¡Combinación correcta!")
		# Si coinciden, se busca el puzzle ganador y se vuelve true dentro del jugador
		var puzzle_key = "Puzzle" + puzzle_ganador
		if puzzle_key in Globals.puzzles:
			$Ganaste.play()
			victoriaPuzzle2.emit()
			Globals.puzzles[puzzle_key] = true
			print("¡Has ganado!")
			print("puzzle"+puzzle_ganador+" "+str(Globals.puzzles[puzzle_key]))
		else:
			print("El puzzle ganador no está definido en Globals.puzzles.")
	
	else:
		print("Combinación incorrecta.")
		
func DisminuirListaDeBotonesEnElDiccionario():
	for i in range(1, CantidadBotonesCombinacionSecreta + 1):
		var boton_nombre = "boton" + str(i)
		nuevobotones[boton_nombre] = combinacion_secreta[boton_nombre]
		nuevobotones[boton_nombre] = false
		
