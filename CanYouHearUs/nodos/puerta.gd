extends Node3D

@export var NecesitoLlave = false
@export var LlaveNecesaria = "item1"
@export var alertaLlaveNecesaria = "Llave 1"
@export var soyPortal = false
@export var Mapa = "res://lvls/level_1.tscn"
@export var PosicionEnNuevoMapa = Vector3(0,0,0)

var puertaAbierta = false
var jugadorDentro = false
var entroPorFrente = false
var entroPorEspalda = false

var MaterialOutline : Shader = load("res://shader/Outline.gdshader")



# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/Label.set_text("Cerrado con "+alertaLlaveNecesaria)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	checkearLadoColision()
	RayoChocaConmigo()
	if NecesitoLlave:
		siSoyPortal()
		if Input.is_action_just_pressed("Clickear") and entroPorFrente and Globals.infoJugador["inventario"][LlaveNecesaria] == true and !soyPortal:
			if !puertaAbierta:
				$Open.play()
			animacionFrente()
			desvanecerAlerta()
			puertaAbierta = true
			
		elif Input.is_action_just_pressed("Clickear") and entroPorFrente and Globals.infoJugador["inventario"][LlaveNecesaria] == false:
			$ColorRect.show()
			$ColorRect.modulate.a = 1
			
		if Input.is_action_just_pressed("Clickear") and entroPorEspalda and Globals.infoJugador["inventario"][LlaveNecesaria] == true and !soyPortal:
			if !puertaAbierta:
				$Open.play()
			animacionEspalda()
			desvanecerAlerta()
			puertaAbierta = true
			
		elif Input.is_action_just_pressed("Clickear") and entroPorEspalda and Globals.infoJugador["inventario"][LlaveNecesaria] == false:
			$ColorRect.show()
			$ColorRect.modulate.a = 1
	else:
		if Input.is_action_just_pressed("Clickear") and entroPorFrente:
			if !puertaAbierta:
				$Open.play()
			animacionFrente()
			desvanecerAlerta()
			puertaAbierta = true
			
		if Input.is_action_just_pressed("Clickear") and entroPorEspalda:
			if !puertaAbierta:
				$Open.play()
			animacionEspalda()
			desvanecerAlerta()
			puertaAbierta = true
		

func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		jugadorDentro = true


func _on_area_3d_body_exited(body):
	if puertaAbierta:
		animacionVolverANormal()
		
	
	if body.is_in_group("Jugador"):
		jugadorDentro = false
		desvanecerAlerta()


func checkearLadoColision():
	if jugadorDentro and $Ray_frente.is_colliding():
		entroPorFrente = true
	else:
		entroPorFrente = false
		
	if jugadorDentro and $Ray_espalda.is_colliding():
		entroPorEspalda = true
	else:
		entroPorEspalda = false

func animacionFrente():
	var tween = create_tween()
	tween.tween_property($pivote,"rotation_degrees:y",90,1).set_trans(Tween.TRANS_SINE)
	
func animacionEspalda():
	var tween = create_tween()
	tween.tween_property($pivote,"rotation_degrees:y",-90,1).set_trans(Tween.TRANS_SINE)
	
func animacionVolverANormal():
	$Closed.play()
	puertaAbierta = false
	var tween = create_tween()
	tween.tween_property($pivote,"rotation_degrees:y",0,1).set_trans(Tween.TRANS_SINE)


func desvanecerAlerta():
	var tween = create_tween()
	tween.tween_property($ColorRect,"modulate:a",0,1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback($ColorRect.hide)

func RayoChocaConmigo():
	if entroPorFrente || entroPorEspalda:
		$pivote/StaticBody3D/CollisionShape3D/MeshInstance3D.material_override.next_pass.shader = MaterialOutline
	else:
		$pivote/StaticBody3D/CollisionShape3D/MeshInstance3D.material_override.next_pass=ShaderMaterial.new()
		
func siSoyPortal():
	if Input.is_action_just_pressed("ui_accion") and entroPorFrente and Globals.infoJugador["inventario"][LlaveNecesaria] == true and soyPortal:
		$Fadeout.play("fadeout")
		Globals.JugadorPosNuevaPortal = PosicionEnNuevoMapa
		Globals.VengoDeUnPortal = true
		


func _on_fadeout_animation_finished(_anim_name):
	get_tree().change_scene_to_file(Mapa)
