extends StaticBody3D
@export var Lugar = "lugar1"
@export var MiPapa = Node3D
@export var Jugador = Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	AyudaVisual()
	SaberConQuienEstoyColisionando()
	Colisiones()


func SaberConQuienEstoyColisionando():
	if Jugador.puedointeractuar and Jugador.ConqueEstoyInteractuando == self:
		MiPapa.LugarMouse = Lugar

func Colisiones():
	if Globals.PickPuzzle == false and MiPapa.piezas_colocadas[Lugar]["pieza"] !="null":
		$CollisionShape3D.disabled = true
	elif Globals.PickPuzzle == true and MiPapa.piezas_colocadas[Lugar]["pieza"] =="null":
		$CollisionShape3D.disabled = false

func AyudaVisual():
	if Globals.PickPuzzle and Jugador.puedointeractuar and Jugador.ConqueEstoyInteractuando == self:
		$Sprite3D.show()
	else:
		$Sprite3D.hide()
