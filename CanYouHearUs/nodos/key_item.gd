extends StaticBody3D


@export var AvisoItem = Control
@export var Jugador : Node3D
@export var MiID = "item1"
@export var NombreLargo = "Llave legendaria"
var EstoyTomado = false
var NoPickieNada = false


var MaterialOutline : Shader = load("res://shader/Outline.gdshader")

# Called when the node enters the scene tree for the first time.
func _ready():
	SiEstoyEnElInventarioMeBorro()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	RayoChocaConmigo()

func _input(event):
	if event.is_action_pressed("Clickear") and Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar and !Globals.ModoInventario:
		Globals.infoJugador["inventario"][MiID] = true
		AvisoItem.Texto.set_text(NombreLargo)
		hide()
		$Key.play()
		

func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass.shader = MaterialOutline
	else:
		$CollisionShape3D/MeshInstance3D.material_override.next_pass=ShaderMaterial.new()
		

func SiEstoyEnElInventarioMeBorro():
	if Globals.infoJugador["inventario"][MiID] == true:
		queue_free()


func _on_key_finished():
	queue_free()
