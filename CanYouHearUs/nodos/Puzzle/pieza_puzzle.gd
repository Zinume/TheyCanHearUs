extends StaticBody3D
@export var NumeroObjeto = "01"
@export var MiPapa : Node3D
@onready var LugarParaLockear = MiPapa.PosMouse
@export var Jugador : Node3D
var PosInicial = Vector3(0,0,0)
var MeMueven = false
var MaterialOutline : Shader = load("res://shader/Outline.gdshader")
var NoPickieNada = false

func _ready():
	
	PosInicial = global_position

func _process(_delta):
	PiezaSeleccionadaMoverse()
	Colisiones()
	RayoChocaConmigo()
	
func _input(event):
	
	if event.is_action_pressed("Clickear") and Jugador.puedointeractuar and Jugador.ConqueEstoyInteractuando == self and !MeMueven and !Globals.ModoOpciones and !Globals.DeseoVolverAlLevel:
		MiPapa.ObjetoEnMiMano = NumeroObjeto
		Globals.PickPuzzle = true
		MeMueven = true
		SacarmeDeAlgunArea()
		var tween = create_tween()
		tween.tween_property(self,"scale",Vector3(1.3,1.3,1.3),0.15).set_trans(Tween.TRANS_SINE)
		
	elif event.is_action_pressed("Clickear") and !Jugador.puedointeractuar and !Globals.ModoOpciones and !Globals.DeseoVolverAlLevel:
		NoPickieNada = true
		Globals.PickPuzzle = true
		
	if Input.is_action_just_released("Clickear") and !Globals.ModoOpciones:
		if Globals.puzzles["Puzzle" + MiPapa.puzzle_ganador] == false:
			MiPapa.verificarVictoria()
		NoPickieNada = false
		Globals.PickPuzzle = false
		var tween = create_tween()
		tween.tween_property(self,"scale",Vector3(1,1,1),0.15).set_trans(Tween.TRANS_SINE)
		
	if Input.is_action_just_released("Clickear") and Jugador.puedointeractuar and MeMueven and MiPapa.objetos_en_zonas[MiPapa.LugarMouse]["valor"] == null and !NoPickieNada and !Globals.ModoOpciones:
		MeMueven = false
		Globals.PickPuzzle = false
		NuevaPosicionEnArea()
		NoPickieNada = false
		
	if Input.is_action_just_released("Clickear") and !Jugador.puedointeractuar and MiPapa.ObjetoEnMiMano == NumeroObjeto and !NoPickieNada and MeMueven and !Globals.ModoOpciones:
		MeMueven = false
		Globals.PickPuzzle = false
		VuelvoAMiPosicionInicial()
		NoPickieNada = false
	
	

func NuevaPosicionEnArea():
	global_position = MiPapa.objetos_en_zonas[MiPapa.LugarMouse]["position"]
	AgregarmeAAlgunAreaEnLista()

func SacarmeDeAlgunArea():
	MiPapa.liberarZona(NumeroObjeto)

func AgregarmeAAlgunAreaEnLista():
	MiPapa.asignarObjetoAZona(NumeroObjeto, MiPapa.LugarMouse)

func VuelvoAMiPosicionInicial():
	global_position = PosInicial

func PiezaSeleccionadaMoverse():
	if MeMueven:
		global_position = Jugador.pickpuzzle.global_position
		
func Colisiones():
	if Globals.PickPuzzle == false:
		$CollisionShape3D.disabled = false
	else:
		$CollisionShape3D.disabled = true
		


func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass.shader = MaterialOutline
	else:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass=ShaderMaterial.new()
