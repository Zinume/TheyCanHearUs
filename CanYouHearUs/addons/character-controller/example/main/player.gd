extends FPSController3D
class_name Player

## Example script that extends [CharacterController3D] through 
## [FPSController3D].
## 
## This is just an example, and should be used as a basis for creating your 
## own version using the controller's [b]move()[/b] function.
## 
## This player contains the inputs that will be used in the function 
## [b]move()[/b] in [b]_physics_process()[/b].
## The input process only happens when mouse is in capture mode.
## This script also adds submerged and emerged signals to change the 
## [Environment] when we are in the water.

@export var input_back_action_name := "move_backward"
@export var input_forward_action_name := "move_forward"
@export var input_left_action_name := "move_left"
@export var input_right_action_name := "move_right"
@export var input_sprint_action_name := "move_sprint"
@export var input_jump_action_name := "move_jump"
@export var input_crouch_action_name := "move_crouch"
@export var input_fly_mode_action_name := "move_fly_mode"

@export var underwater_env: Environment

@export var LuzLinterna = 5.5
@onready var pickpos = $Head/Camera/PickPos
@onready var pickpuzzle = $Head/Camera/PickPuzzle
@onready var picktext = $Head/Camera/pickText
@onready var camara: Camera3D = $Head/Camera
@onready var cameraorigin = $Head/CameraOrigin
@onready var Colisionador = $Collision
var puedointeractuar = false
@onready var ConqueEstoyInteractuando = $Head/Camera/RayCast3D.get_collider()
var actual_rotation := Vector3()
var BlurCamera = 10
var ModoBlur = false
<<<<<<< Updated upstream
=======
@export var LinternaEncendida = false
>>>>>>> Stashed changes

signal jugadorNoHablaPorMic
signal jugadorHablancoPorMic
signal jugadorEstaGritandoPorMic

func _ready():
	#mis funciones
	setMouseYLinterna()
	guardarNombreDeNivel()
	cargarPosJugador()
	#valor linterna
	$Head/Camera/SpotLight3D.light_energy = LuzLinterna
	
	##########
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	setup()
	emerged.connect(_on_controller_emerged.bind())
	submerged.connect(_on_controller_subemerged.bind())

func _process(delta):
	checkLinterna()
	BlureoCamara()
	guardarPosJugador()
	zoom()
	colorPuntero()
	
	
	


func _physics_process(delta):	
	
	if Globals.ModoPlay == true and !Globals.ModoOpciones and !Globals.ModoInventario and !Globals.ModoChat:
		var is_valid_input := Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
		if is_valid_input:
			if Input.is_action_just_pressed(input_fly_mode_action_name):
				fly_ability.set_active(not fly_ability.is_actived())
			var input_axis = Input.get_vector(input_back_action_name, input_forward_action_name, input_left_action_name, input_right_action_name)
			var input_jump = Input.is_action_just_pressed(input_jump_action_name)
			var input_crouch = Input.is_action_pressed(input_crouch_action_name)
			var input_sprint = Input.is_action_pressed(input_sprint_action_name)
			var input_swim_down = Input.is_action_pressed(input_crouch_action_name)
			var input_swim_up = Input.is_action_pressed(input_jump_action_name)
			move(delta, input_axis, input_jump, input_crouch, input_sprint, input_swim_down, input_swim_up)
		else:
			# NOTE: It is important to always call move() even if we have no inputs 
			## to process, as we still need to calculate gravity and collisions.
			move(delta)


func _input(event: InputEvent) -> void:
		
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and !Globals.ModoOpciones and !Globals.PickieUnObItem and !Globals.ModoInventario:
		rotate_head(event.relative)


func _on_controller_emerged():
	camera.environment = null


func _on_controller_subemerged():
	camera.environment = underwater_env
	
	

func guardarPosJugador():
	if Globals.infoJugador["posicion"] != global_position:
		Globals.infoJugador["posicion"] = global_position 
	if Globals.infoJugador["rotacion"] != rotation:
		Globals.infoJugador["rotacion"] = rotation
		
		
func cargarPosJugador():
	if Globals.infoJugador["posicion"] !=Vector3(0,0,0):
		if Globals.AcaboDeCargar == true:
			global_position = Globals.infoJugador["posicion"]
			rotation = Globals.infoJugador["rotacion"] 
			Globals.AcaboDeCargar = false
			
	if Globals.JugueUnPuzzleYQuieroSalir == true:
		global_position = Globals.JugadorPosAnterior
		Globals.JugueUnPuzzleYQuieroSalir = false
		
	if Globals.VengoDeUnPortal == true:
		global_position = Globals.JugadorPosNuevaPortal
		rotation = Globals.JugadorRotNuevaPortal
		Globals.VengoDeUnPortal = false
		
func BlureoCamara():
	$Head/Camera.attributes.dof_blur_far_enabled = ModoBlur
	$Head/Camera.attributes.dof_blur_far_distance = BlurCamera

func guardarNombreDeNivel():
	Globals.infoJugador["escenaACargar"] = get_tree().current_scene.scene_file_path

func zoom():
	if Input.is_action_pressed("zoom")and Globals.ModoPlay == true and !Globals.ModoOpciones and !Globals.ModoInventario and !Globals.ModoChat:
		camara.fov = 40

func colorPuntero():
	if $Head/Camera/RayCast3D.is_colliding():
		puedointeractuar = true
		ConqueEstoyInteractuando = $Head/Camera/RayCast3D.get_collider()
		$Head/Camera/ColorRect.color = Color.ORANGE_RED
	else:
		puedointeractuar = false
		$Head/Camera/ColorRect.color = Color.WHITE
		

func mirarNpc(pos:Vector3):
	#El nodo MirarNpc solo sirve en esta funcion
	$Head/Camera/MirarNpc.look_at(pos)
	var rot_queQuiero = $Head/Camera/MirarNpc.rotation
	var tween = create_tween()
	tween.tween_property(camara,"rotation",rot_queQuiero,1)
	tween.parallel().tween_property(camara,"fov",40,1)
<<<<<<< Updated upstream
=======

func linterna():
	if Input.is_action_just_pressed("Linterna") and !Globals.ModoOpciones and !Globals.ModoInventario and !Globals.ModoChat and !LinternaEncendida:
		LinternaEncendida = true
		$Linterna.play()
	elif Input.is_action_just_pressed("Linterna") and !Globals.ModoOpciones and !Globals.ModoInventario and !Globals.ModoChat and LinternaEncendida:
		LinternaEncendida = false
		$Linterna.play()

func checkLinterna():
	Globals.infoJugador["Linterna"] = LinternaEncendida
	if LinternaEncendida:
		$Head/Camera/SpotLight3D.light_energy = LuzLinterna
	elif !LinternaEncendida:
		$Head/Camera/SpotLight3D.light_energy = 0
		

func setMouseYLinterna():
	LinternaEncendida = Globals.infoJugador["Linterna"]
	mouse_sensitivity = Globals.opcionesParametros["Mouse_sen"]
>>>>>>> Stashed changes
