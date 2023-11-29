extends Node3D

@onready var audio = $ProgressBar/AudioStreamPlayer

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(audio.bus)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var sample = AudioServer.get_bus_peak_volume_left_db(bus_index,0)
	
	var linear_sample = db_to_linear(sample)*Globals.opcionesParametros["MicSen"]
	$ProgressBar.value = linear_sample
	Globals.opcionesParametros["ValorMic"] = linear_sample
	var barra_int : int = int(linear_sample)
	
	if barra_int in range(0,2):
		$ProgressBar.self_modulate = Color.WHITE
		get_parent().jugadorNoHablaPorMic.emit()
	elif barra_int in range(2,9):
		$ProgressBar.self_modulate = Color.YELLOW
		get_parent().jugadorHablancoPorMic.emit()
	elif barra_int in range(9,30):
		$ProgressBar.self_modulate = Color.RED
		get_parent().jugadorEstaGritandoPorMic.emit()
