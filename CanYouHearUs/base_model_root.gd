extends CharacterBody3D

@export var chatBox : CanvasLayer
@export var CualNpcSoy = "npc01"
@export var deboMirarAlJugadorEnChat = false
@export var mePuedenHablar = false
@export var deboMoverme = false

@export var target : CharacterBody3D

var zonaActual: String = "zona_1"


@export var zona_1 : Marker3D
@export var zona_2 : Marker3D
@export var zona_3 : Marker3D
@export var zona_4 : Marker3D
@export var zona_5 : Marker3D
@export var zona_6 : Marker3D
@export var zona_7 : Marker3D
@export var zona_8 : Marker3D
@export var zona_9 : Marker3D
@export var zona_10 : Marker3D

var posicionesZonas = {
	"zona_1" : Vector3(0,0,0),
	"zona_2" : Vector3(0,0,0),
	"zona_3" : Vector3(0,0,0),
	"zona_4" : Vector3(0,0,0),
	"zona_5" : Vector3(0,0,0),
	"zona_6" : Vector3(0,0,0),
	"zona_7" : Vector3(0,0,0),
	"zona_8" : Vector3(0,0,0),
	"zona_9" : Vector3(0,0,0),
	"zona_10" : Vector3(0,0,0)
}

var delay: bool = true
var estoyViendo: bool  = false
var estoyEnRutina: bool  = false
var jugadorChateaConmigo: bool = false
@onready var Ik = $base_model/Armature_001/Skeleton3D/SkeletonIK3D
@onready var agent = $NavigationAgent3D
@onready var footstep = $Footstep
var Speed = 1
var targ: Vector3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready():
	#coneccionConChatBox()
	coneccionDelayConChatbox()
	checkearZonasYAgregarPosicion()
	Ik.start()


func _physics_process(delta):
	distanciaConObjetivoMoverse(delta)
	gravedadYAnimacion(delta)
	move_and_slide()


func _process(_delta):
	targ = posicionesZonas[zonaActual]
	updateTargetLocation(targ)
	EstoyViendoAlJugador()
	interaccion()
	

func gravedadYAnimacion(delta):
	if not is_on_floor():
		velocity.y -=gravity*delta
	
	if velocity.length() > 0 and deboMoverme:
		velocity = velocity.normalized() * Speed
		#walk
		look_at(targ,Vector3.UP,true)
		rotation.x = 0
		rotation.z = 0
		$AnimationTree["parameters/Transition/transition_request"] = "walk"
	else:
		#idle
		$AnimationTree["parameters/Transition/transition_request"] = "idle"


func EstoyViendoAlJugador():
	if estoyViendo:
		#targ = target.global_position
		#updateTargetLocation(targ)
		$base_model/Marker3D.look_at(target.camara.global_transform.origin,Vector3.UP,true)
		if Ik.interpolation < 1:
			Ik.interpolation +=0.03 
	else:
		if Ik.interpolation > 0:
			Ik.interpolation -=0.01


func updateTargetLocation(objetivo):
	agent.set_target_position(objetivo)


func distanciaConObjetivoMoverse(delta):
	if position.distance_to(targ)> 1 and !estoyViendo and deboMoverme:
		estoyEnRutina = false
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc-curLoc).normalized()*Speed
		velocity = newVel
		if not is_on_floor():
			velocity.y -=gravity*delta
	else:
		velocity = Vector3(0,0,0)
		if !estoyEnRutina and !estoyViendo:
			$Rutina.start()
			estoyEnRutina = true
			

func checkearZonasYAgregarPosicion():
	if is_instance_valid(zona_1):
		posicionesZonas["zona_1"] = zona_1.global_position
	if is_instance_valid(zona_2):
		posicionesZonas["zona_2"] = zona_2.global_position
	if is_instance_valid(zona_3):
		posicionesZonas["zona_3"] = zona_3.global_position
	if is_instance_valid(zona_4):
		posicionesZonas["zona_4"] = zona_4.global_position
	if is_instance_valid(zona_5):
		posicionesZonas["zona_5"] = zona_5.global_position
	if is_instance_valid(zona_6):
		posicionesZonas["zona_6"] = zona_6.global_position
	if is_instance_valid(zona_7):
		posicionesZonas["zona_7"] = zona_7.global_position
	if is_instance_valid(zona_8):
		posicionesZonas["zona_8"] = zona_8.global_position
	if is_instance_valid(zona_9):
		posicionesZonas["zona_9"] = zona_9.global_position
	if is_instance_valid(zona_10):
		posicionesZonas["zona_10"] = zona_10.global_position


func obtener_siguiente_zona(zona_actual):
	
	# Lógica para obtener la siguiente zona en base a la zona actual
	# En este ejemplo, simplemente avanzamos numéricamente a la siguiente zona
	var zona_numerica = int(zona_actual.split("_")[1])  # Extrae el número de la zona actual
	zona_numerica += 1  # Avanza a la siguiente zona
	var siguiente_zona = "zona_" + str(zona_numerica)  # Construye el nombre de la siguiente zona
	# Verifica si la siguiente zona existe en el diccionario de posicionesZonas
	if siguiente_zona in posicionesZonas and posicionesZonas[siguiente_zona] != Vector3(0,0,0):
		return siguiente_zona
	else:
		siguiente_zona = "zona_1"
		print('no hay mas zonas')
		return siguiente_zona  # No hay más zonas disponibles


func interaccion():
	if deboMirarAlJugadorEnChat:
		if Input.is_action_just_pressed("Clickear") and target.ConqueEstoyInteractuando == self and target.puedointeractuar and !Globals.ModoChat and !Globals.ModoOpciones and mePuedenHablar and delay:
			delay = false
			print('volvi a clickear')
			#Globals.ModoChat = true
			chatBox.CualNPCSoy = CualNpcSoy
			chatBox.CheckRutaHistoria(CualNpcSoy)
			chatBox.ChatBox_activado()
			#chatBox.CambiarSpriteNPC(CualNpcSoy)
			chatBox.Setear_text(DialogosNpc.dialogos[CualNpcSoy][chatBox.TextoPersonaje00])
			chatBox.AnimacionTexto()
			jugadorMeMira()
			if !estoyViendo:
				voltearAMirarAlJugador()
			
	else:
		if Input.is_action_just_pressed("Clickear") and estoyViendo and target.ConqueEstoyInteractuando == self and target.puedointeractuar and !Globals.ModoChat and !Globals.ModoOpciones and mePuedenHablar and delay:
			delay = false
			#Globals.ModoChat = true
			chatBox.CualNPCSoy = CualNpcSoy
			chatBox.CheckRutaHistoria(CualNpcSoy)
			chatBox.ChatBox_activado()
			#chatBox.CambiarSpriteNPC(CualNpcSoy)
			chatBox.Setear_text(DialogosNpc.dialogos[CualNpcSoy][chatBox.TextoPersonaje00])
			chatBox.AnimacionTexto()
			jugadorMeMira()
		

func footSteps():
	footstep.pitch_scale = randf_range(0.6,1.2)
	footstep.play()

func voltearAMirarAlJugador():
	print('Me volteo a ti')
	estoyViendo= true
	var tween = create_tween()
	# rotar usando look_at
	$Pos_rotation.look_at(target.global_position,Vector3.UP,true)
	# obtener rotacion
	var rot_wanted = $Pos_rotation.global_rotation.y 
	# interpolar con tween
	tween.tween_property(self, "rotation:y", rot_wanted, 0.7)


func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		estoyViendo = true
		


func _on_area_3d_body_exited(body):
	if body.is_in_group('Jugador'):
		estoyViendo = false


func _on_rutina_timeout():
	zonaActual = obtener_siguiente_zona(zonaActual)
	

func dejoDeMirar():
	estoyViendo = false
	
func delayTimer():
	$Timer_delay.start()
	
func coneccionDelayConChatbox():
	chatBox.fin_de_dialogo.connect(delayTimer)

	
func coneccionConChatBox():
	chatBox.fin_de_dialogo.connect(dejoDeMirar)
	
	
func jugadorMeMira():
	target.mirarNpc($base_model/Marker3D.global_position)


func _on_timer_delay_timeout():
	
	delay = true
