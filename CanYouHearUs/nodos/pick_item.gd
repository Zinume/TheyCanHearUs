extends RigidBody3D

@export var player : Node3D
@onready var pick_item = $CollisionShape3D/MeshInstance3D
@onready var pickposition = player.pickpos
@onready var MepuedePickear = player.puedointeractuar
@onready var RotacionInicial = pick_item.rotation_degrees

var NoPickieNada = false

var MaterialOutline : Shader = load("res://shader/Outline.gdshader")
var EstoyTomado = false

func _ready():
	#position = $CollisionShape3D.position
	pick_item.material_override.next_pass.shader = MaterialOutline
	
func _process(_delta):
	MepuedePickear = player.puedointeractuar
	
	#Cargar el outline de la variable y sus condiciones
	CondicionesOutline()
	
	#cambiar posicion del objeto
	EstoyTomadoPorJugador()
	
	#accion para tomar
	if Input.is_action_pressed("Clickear") and MepuedePickear and !Globals.ModoOpciones and !Globals.PickieUnObjecto and player.ConqueEstoyInteractuando == self and !NoPickieNada and !Globals.ModoInventario:
		EstoyTomado = true
		Globals.PickieUnObjecto = true
		$Sound.play()
		
	elif Input.is_action_pressed("Clickear") and !player.puedointeractuar and !Globals.ModoOpciones:
		NoPickieNada = true
		
	if Input.is_action_just_released("Clickear") and !Globals.ModoOpciones and Globals.PickieUnObjecto:
		$Sound2.play()
		
	if Input.is_action_just_released("Clickear") and !Globals.ModoOpciones:
		NoPickieNada = false
		EstoyTomado = false
		Globals.PickieUnObjecto = false
		
	


func EstoyTomadoPorJugador():
	if EstoyTomado:
		position = pickposition.global_position
		rotation = RotacionInicial
		
		
func CondicionesOutline():
	if player.ConqueEstoyInteractuando == self and MepuedePickear and !Globals.PickieUnObjecto :
		pick_item.material_override.next_pass.shader = MaterialOutline
		
	elif EstoyTomado:
		pick_item.material_override.next_pass.shader = MaterialOutline
	else:
		pick_item.material_override.next_pass=ShaderMaterial.new()
