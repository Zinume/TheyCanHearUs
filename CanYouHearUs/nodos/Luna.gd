extends MeshInstance3D

@export var jugador = CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	global_position = jugador.global_position + Vector3(10,35,-34)
