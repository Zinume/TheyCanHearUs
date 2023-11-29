extends Area3D

@export var NuevoMapa: String = "res://lvls/level_intro.tscn"
@export var PosicionEnNuevoMapa : Vector3
@export var RotacionEnNuevoMapa : Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Jugador"):
		Globals.JugadorPosNuevaPortal = PosicionEnNuevoMapa
		Globals.JugadorRotNuevaPortal = RotacionEnNuevoMapa
		Globals.VengoDeUnPortal = true
		get_tree().change_scene_to_file(NuevoMapa)
