extends StaticBody3D

var QueBotonSoy = null
var toggle_state = false
@export var MiPapa = Node3D
@export var Jugador = Node3D

var EstoyEnAreaDelBoton = false

var MaterialOutline : Shader = load("res://shader/Outline.gdshader")
# Diccionario que mapea nombres a valores
var diccionario = {
	"boton1": "boton1",
	"boton2": "boton2",
	"boton3": "boton3",
	"boton4": "boton4",
	"boton5": "boton5",
	"boton6": "boton6",
	"boton7": "boton7",
	"boton8": "boton8"
}

# Variables exportadas de tipo booleano
@export var MiNombreSera_boton1 : bool = false
@export var MiNombreSera_boton2 : bool = false
@export var MiNombreSera_boton3 : bool = false
@export var MiNombreSera_boton4 : bool = false
@export var MiNombreSera_boton5 : bool = false
@export var MiNombreSera_boton6 : bool = false
@export var MiNombreSera_boton7 : bool = false
@export var MiNombreSera_boton8 : bool = false



func _ready():
	checkSelectedButton()
	MandarMiEstadoAPadre()

func checkSelectedButton():
	for boton_numero in range(1, 9):
		var nombre_variable = "MiNombreSera_boton" + str(boton_numero)
		if self[nombre_variable]:
			var valor_diccionario = diccionario["boton" + str(boton_numero)]
			print("El valor seleccionado es:", valor_diccionario)
			QueBotonSoy = valor_diccionario
			return
	
	print("Ningún botón está seleccionado.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	RayoChocaConmigo()

func _input(event):
	if event.is_action_pressed("Clickear") and EstoyEnAreaDelBoton and !Globals.ModoOpciones and !Globals.DeseoVolverAlLevel:
		# Cambia el estado del toggle cuando se presiona la tecla "Espacio" o se hace clic con el ratón
		toggle_state = not toggle_state
		# Realiza acciones según el estado del toggle
		if toggle_state:
			var tween = create_tween()
			tween.tween_property($CollisionShape3D/MeshInstance3D,"position",Vector3(0,-0.13,0),0.5).set_trans(Tween.TRANS_ELASTIC)
			print("Toggle activado (true)")
		else:
			var tween = create_tween()
			tween.tween_property($CollisionShape3D/MeshInstance3D,"position",Vector3(0,0,0),0.5).set_trans(Tween.TRANS_ELASTIC)
			print("Toggle desactivado (false)")
		MandarMiEstadoAPadre()
		PreguntarAPadreSiGane()
		#print(MiPapa.nuevobotones)

	
func PreguntarAPadreSiGane():
	MiPapa.verificarCombinacion()

func MandarMiEstadoAPadre():
	MiPapa.nuevobotones[QueBotonSoy] = toggle_state
	
func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass.shader = MaterialOutline
		EstoyEnAreaDelBoton = true
	else:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass=ShaderMaterial.new()
		EstoyEnAreaDelBoton = false
