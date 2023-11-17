extends StaticBody3D
@export var Lugar = ""
@export var MiPapa = Node3D
@export var Jugador = Node3D
@onready var MepuedePickear = Jugador.puedointeractuar

func _ready():
	pass # Replace with function body.

func _process(_delta):
	#print(MiPapa.LugarMouse)
	SaberConQuienEstoyColisionando()
	AyudaVisual()
	Colisiones()

func AyudaVisual():
	if Globals.PickPuzzle and MepuedePickear and Jugador.ConqueEstoyInteractuando == self:
		$Sprite3D.show()
	else:
		$Sprite3D.hide()
		
func SaberConQuienEstoyColisionando():
	MepuedePickear = Jugador.puedointeractuar
	if MepuedePickear and Jugador.ConqueEstoyInteractuando == self:
		MiPapa.LugarMouse = Lugar
		
func Colisiones():
	if Globals.PickPuzzle == false and MiPapa.objetos_en_zonas[Lugar]["valor"] !=null:
		$CollisionShape3D.disabled = true
	elif Globals.PickPuzzle == true and MiPapa.objetos_en_zonas[Lugar]["valor"] ==null:
		$CollisionShape3D.disabled = false
		
