extends StaticBody3D
@export var pieza = "pieza1"
@export var MiPapa = Node3D
@export var Jugador = Node3D
var rotacionTween = 0
var pieza_estado = 1
var EstoyEnAreaDeLaPieza = false
var MaterialOutline : Shader = load("res://shader/Outline.gdshader")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(pieza_estado)
	RayoChocaConmigo()


func _input(event):
	if event.is_action_pressed("Clickear") and EstoyEnAreaDeLaPieza and !Globals.ModoOpciones and !Globals.DeseoVolverAlLevel:
		rotate_object()
		

func rotate_object():
	# Gira el objeto 90 grados
	rotacionTween += 90
	var tween = create_tween()
	tween.tween_property(self,"rotation_degrees",Vector3(1,rotacionTween,1),0.72).set_trans(Tween.TRANS_ELASTIC)
	pieza_estado = (pieza_estado % 4) + 1
	EnviarMiEstado()
	checkarVictoria()
	
	
func EnviarMiEstado():
	MiPapa.nueva_combinacion[pieza]= pieza_estado

func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass.shader = MaterialOutline
		EstoyEnAreaDeLaPieza = true
	else:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass=ShaderMaterial.new()
		EstoyEnAreaDeLaPieza = false

func checkarVictoria():
	MiPapa.verificarCombinacion()
