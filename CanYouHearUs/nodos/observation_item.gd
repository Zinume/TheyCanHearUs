extends StaticBody3D

@export var Jugador = Node3D

var PosOrigen = Vector3(0,0,0)

var EstoyTomado = false
var NoPickieNada = false

#velocidad de movimiento al tomar el item
var velocidad = 0.000043

# Called when the node enters the scene tree for the first time.
func _ready():
	PosOrigen = global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	RayoChocaConmigo()
	if EstoyTomado:
		global_position = Jugador.pickpuzzle.global_position
		$Node3D/Sprite3D.hide()

func _input(event):
	
	if event is InputEventMouseMotion and EstoyTomado:
		
		if event.relative.x > 0:
			rotate_y(get_viewport().get_mouse_position().x*velocidad )
		elif event.relative.x < 0:
			rotate_y(get_viewport().get_mouse_position().x*-velocidad )
		if event.relative.y > 0:
			rotate_x(get_viewport().get_mouse_position().y*velocidad )
		elif event.relative.y < 0:
			rotate_x(get_viewport().get_mouse_position().y*-velocidad )
	
	
	if event.is_action_pressed("Clickear") and Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar and !Globals.ModoInventario and !Globals.ModoOpciones:
		Globals.PickieUnObItem = true
		EstoyTomado = true
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector3(1.1,1.1,1.1),0.15).set_trans(Tween.TRANS_SINE)
		Globals.ModoPlay = false
		Jugador.ModoBlur = true
		Jugador.BlurCamera = 0.5
		$Sound.play()
	elif Input.is_action_pressed("Clickear") and !Jugador.puedointeractuar and !Globals.ModoOpciones:
		NoPickieNada = true
		
	if event.is_action_released("Clickear") and Jugador.ConqueEstoyInteractuando == self:
		$Node3D/Sprite3D.show()
		Globals.PickieUnObItem = false
		EstoyTomado = false
		global_transform = PosOrigen
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector3(1,1,1),0.15).set_trans(Tween.TRANS_SINE)
		Globals.ModoPlay = true
		Jugador.ModoBlur = false
		$Sound2.play()
		
	if event.is_action_released("Clickear"):
		NoPickieNada = false
		
func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == self and Jugador.puedointeractuar:
		$AnimationPlayer.play("interactuar")
	else:
		$AnimationPlayer.stop()
		$Node3D.scale = Vector3(1,1,1)




func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		$Node3D/Sprite3D.show()


func _on_area_3d_body_exited(body):
	if body.is_in_group('Jugador'):
		$Node3D/Sprite3D.hide()
