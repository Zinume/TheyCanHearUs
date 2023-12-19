extends Node3D

@export var Jugador = CharacterBody3D
@export var AvisoItem = Control
@export var AvisoTexto: String = "Diario o Pista"
@export var queItemSoy = "diario1 o pista1"
@export var soyDiario = false

signal tomeItem

var EstoyTomado = false
var NoPickieNada = false
var PosOrigen = Vector3(0,0,0)
var EstoyLeyendo = false




# Called when the node enters the scene tree for the first time.
func _ready():
	PosOrigen = global_transform
	#si no soy diario, soy pista. Y seteo el texto del contenido Pistas, lo mismo pero con el diario.
	if !soyDiario:
		$Control/ColorRect/Label.set_text(Inventario.contenidoPistas["pista"][queItemSoy])
	elif soyDiario:
		siEstoyEnElInventarioMeBorro()
		$Control/ColorRect/Label.set_text(Inventario.contenidoDiario["diario"][queItemSoy])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	RayoChocaConmigo()
	if EstoyTomado:
		global_position = Jugador.picktext.global_position
		$Area3D2/CollisionShape3D/Sprite3D.billboard = true
		$Area3D/CollisionShape3D/Node3D/Sprite3D.hide()
	
func _input(event):
	
	if event.is_action_pressed("Clickear") and Jugador.ConqueEstoyInteractuando == $Area3D2 and Jugador.puedointeractuar and !Globals.ModoInventario and !Globals.ModoOpciones and !Globals.PickiUnTexto and !Globals.ModoChat:
		Globals.PickiUnTexto = true
		EstoyTomado = true
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector3(0.8,0.8,0.8),0.15).set_trans(Tween.TRANS_SINE)
		Globals.ModoPlay = false
		Jugador.ModoBlur = true
		Jugador.BlurCamera = 0.5
		$Control.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Papel.play()
		$Control/ColorRect/Button.grab_focus()
		
	elif Input.is_action_pressed("Clickear") and !Jugador.puedointeractuar and !Globals.ModoOpciones:
		NoPickieNada = true
		
	if event.is_action_released("Clickear"):
		NoPickieNada = false

func RayoChocaConmigo():
	if Jugador.ConqueEstoyInteractuando == $Area3D2  and Jugador.puedointeractuar:
		$AnimationPlayer.play("interactuar")
	else:
		$AnimationPlayer.stop()
		$Area3D/CollisionShape3D/Node3D.scale = Vector3(1,1,1)
		


func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		$Area3D/CollisionShape3D/Node3D/Sprite3D.show()


func _on_area_3d_body_exited(body):
	if body.is_in_group('Jugador'):
		$Area3D/CollisionShape3D/Node3D/Sprite3D.hide()


func _on_button_pressed():
	if !soyDiario and !Globals.ModoInventario and !Globals.ModoOpciones:
		$Area3D/CollisionShape3D/Node3D/Sprite3D.show()
		Globals.PickiUnTexto = false
		EstoyTomado = false
		global_transform = PosOrigen
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector3(1,1,1),0.15).set_trans(Tween.TRANS_SINE)
		Globals.ModoPlay = true
		Jugador.ModoBlur = false
		$Area3D2/CollisionShape3D/Sprite3D.billboard = false
		$Control.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$Click2.play()
		
	elif soyDiario and !Globals.ModoInventario and !Globals.ModoOpciones:
		$Area3D/CollisionShape3D/Node3D/Sprite3D.show()
		Globals.PickiUnTexto = false
		EstoyTomado = false
		global_transform = PosOrigen
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector3(1,1,1),0.15).set_trans(Tween.TRANS_SINE)
		Globals.ModoPlay = true
		Jugador.ModoBlur = false
		$Area3D2/CollisionShape3D/Sprite3D.billboard = false
		$Control.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Globals.infoJugador["inventario"][queItemSoy] = true
		$Click2.play()
		tomeItem.emit()
		AvisoItem.Texto.text = AvisoTexto
		tween.stop()
		queue_free()
		

func siEstoyEnElInventarioMeBorro():
	if Globals.infoJugador["inventario"][queItemSoy] == true:
		queue_free()
