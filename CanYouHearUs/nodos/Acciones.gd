extends CanvasLayer

signal accion_1_completada
signal accion_2_completada

@export var player : Player

@export var intensidadVoz: float = 2.0
var barra_accion_1: float = 0.0
var barra_accion_2: float = 0.0

var JugadorHablandoPorMic = false
var JugadorGritandoPorMic = false

@onready var nodo_accion1 = $VBoxContainer/Accion1
@onready var nodo_accion2 = $VBoxContainer/Accion2


# Called when the node enters the scene tree for the first time.
func _ready():
	coneccionesConPlayerMic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	nodo_accion1.value = barra_accion_1
	nodo_accion2.value = barra_accion_2
	metaAccion_1()
	metaAccion_2()
	quitarValueAccion_1()
	quitarValueAccion_2()
	
func _physics_process(_delta):
	controlesInput()

func metaAccion_1():
	if nodo_accion1.value == nodo_accion1.max_value:
		barra_accion_1 = 0
		accion_1_completada.emit()
		
func metaAccion_2():
	if nodo_accion2.value == nodo_accion2.max_value:
		barra_accion_2 = 0
		accion_2_completada.emit()

func quitarValueAccion_1():
	if nodo_accion1.value > 0:
		barra_accion_1 -= 0.15
		
func quitarValueAccion_2():
	if nodo_accion2.value > 0:
		barra_accion_2 -= 0.15


func controlesInput():
	if Input.is_action_pressed("action_1") and !Globals.ModoChat and !Globals.ModoOpciones and JugadorHablandoPorMic and visible:
		barra_accion_1 += intensidadVoz
		
	
	if Input.is_action_pressed("action_2") and !Globals.ModoChat and !Globals.ModoOpciones and JugadorHablandoPorMic and visible:
		barra_accion_2 += intensidadVoz

func signalDelMicJugadorHablando():
	JugadorHablandoPorMic= true
	JugadorGritandoPorMic = false
	

func signalDelMicJugadorCallando():
	JugadorHablandoPorMic= false
	JugadorGritandoPorMic = false

	
func signalDelMicJugadorGritando():
	JugadorHablandoPorMic= false
	JugadorGritandoPorMic = true
	print(JugadorGritandoPorMic)

func coneccionesConPlayerMic():
	AudioGlobal.jugadorHablancoPorMic.connect(signalDelMicJugadorHablando)
	AudioGlobal.jugadorNoHablaPorMic.connect(signalDelMicJugadorCallando)
	AudioGlobal.jugadorEstaGritandoPorMic.connect(signalDelMicJugadorGritando)
	
func esconderHUD():
	hide()

func mostrarHUD():
	show()
