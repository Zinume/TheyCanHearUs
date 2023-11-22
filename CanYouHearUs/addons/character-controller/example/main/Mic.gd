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
	Globals.opcionesParametros["ValorMic"] = int(linear_sample)
	
	if Globals.opcionesParametros["ValorMic"] in range(0,4):
		$ProgressBar.self_modulate = Color.WHITE
	elif Globals.opcionesParametros["ValorMic"] in range(4,9):
		$ProgressBar.self_modulate = Color.YELLOW
	elif Globals.opcionesParametros["ValorMic"] in range(9,30):
		$ProgressBar.self_modulate = Color.RED
	