extends Node3D

signal victoriaPuzzle4

@export var puzzle_ganador = "01"

@export var combinacion_secreta = {
	"pieza1": 1,
	"pieza2": 1,
	"pieza3": 1,
	"pieza4": 1,
	"pieza5": 1,
	"pieza6": 1,
	"pieza7": 1,
	"pieza8": 1
}

var piezas_colocadas = {
	"pieza1": 1,
	"pieza2": 1,
	"pieza3": 1,
	"pieza4": 1,
	"pieza5": 1,
	"pieza6": 1,
	"pieza7": 1,
	"pieza8": 1
}

var nueva_combinacion ={}

@export var CantidadBotonesCombinacionSecreta = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	DisminuirListaDeBotonesEnElDiccionario()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(nueva_combinacion)
	#print(combinacion_secreta)
	pass


func DisminuirListaDeBotonesEnElDiccionario():
	for i in range(1, CantidadBotonesCombinacionSecreta + 1):
		var boton_nombre = "pieza" + str(i)
		nueva_combinacion[boton_nombre] = piezas_colocadas[boton_nombre]


func verificarCombinacion():
	var aciertos = 0
	
	for pieza in combinacion_secreta.keys():
		if pieza in nueva_combinacion and combinacion_secreta[pieza] == nueva_combinacion[pieza]:
			aciertos += 1
			print(aciertos)
		else:
			aciertos += 0
			#break  # Si encuentra una discrepancia, sale del bucle
				
	if aciertos == CantidadBotonesCombinacionSecreta:
		print("¡Combinación correcta!")
		var puzzle_key = "Puzzle" + puzzle_ganador
		if puzzle_key in Globals.puzzles:
			Globals.puzzles[puzzle_key] = true
			victoriaPuzzle4.emit()
			$Ganaste.play()
			print("¡Has ganado!")
			print("puzzle"+puzzle_ganador+" "+str(Globals.puzzles[puzzle_key]))
		else:
			print("El puzzle ganador no está definido en Globals.puzzles.")
	
	else:
		print("Combinación incorrecta.")
