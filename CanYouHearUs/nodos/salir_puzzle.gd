extends Control

@export var NivelAnterior = "res://Test/node_2.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	visibilidad()


func _input(event):
	if event.is_action_pressed("click_back"):
		Globals.DeseoVolverAlLevel = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func visibilidad():
	if Globals.DeseoVolverAlLevel == false:
		hide()
	elif Globals.DeseoVolverAlLevel == true and Globals.ModoOpciones:
		Globals.DeseoVolverAlLevel = false
	else:
		show()



func _on_button_pressed():
	Globals.JugueUnPuzzleYQuieroSalir = true
	Globals.ModoPlay = true
	Globals.DeseoVolverAlLevel = false
	get_tree().change_scene_to_file(NivelAnterior)


func _on_button_2_pressed():
	Globals.DeseoVolverAlLevel = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

