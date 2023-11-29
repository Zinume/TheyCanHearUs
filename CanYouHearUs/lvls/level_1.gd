extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_escena_01_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/AnimationPlayer.play("01")
		$Triggers/Escena_01.queue_free()
