extends Node3D

@export var EscenaACargar = "res://lvls/Zona_Puzzle01.tscn"
@export var Jugador: Node3D
@onready var MepuedePickear = Jugador.puedointeractuar
@onready var Camara_Jugador = Jugador.camara
@onready var Camara_Jugador_origin = Jugador.cameraorigin
@onready var Camara = $Camera3D
@onready var PuzzlePos = $PuzzPos
@onready var ID = $StaticBody3D



@export var min_scale = 0.16 # Escala mínima permitida
@export var max_scale = 0.35 # Escala máxima permitida
@export var max_distance = 4.0 # Distancia máxima
@export var min_distance = 2.5 # Distancia mínima

var JugadorDentro = false


func _ready():
	PuzzlePos.global_transform = Camara.global_transform
	PuzzlePos.rotation = Camara.rotation


func _process(_delta):	
	
	MepuedePickear = Jugador.puedointeractuar

	if JugadorDentro == true:
		EscalaIcon()
	
	if MepuedePickear == true and Jugador.ConqueEstoyInteractuando == ID:
		$Sprite3D/Label3D.show()
	else:
		$Sprite3D/Label3D.hide()

func _physics_process(_delta):

	if Input.is_action_just_pressed("ui_accion") and MepuedePickear == true and Jugador.ConqueEstoyInteractuando == ID and !Globals.ModoInventario and !Globals.ModoOpciones:
		Globals.JugadorPosAnterior = Jugador.global_position
		CamaraBlend()

func _on_area_3d_body_entered(body):
	if body.is_in_group('Jugador'):
		JugadorDentro = true
		$Sprite3D.show()
	


func _on_area_3d_body_exited(body):
	if body.is_in_group('Jugador'):
		JugadorDentro = false
		$Sprite3D.hide()




func EscalaIcon():
	var camera_node = Camara_Jugador
	var camera_position = camera_node.global_transform.origin
	var object_position = global_transform.origin
	var distance_to_camera = object_position.distance_to(camera_position)

	# Calcula la escala en función de la distancia, invirtiendo el cálculo
	var scale_factor = lerp(min_scale, max_scale, clamp((distance_to_camera - min_distance) / (max_distance - min_distance), 0.0, 1.0))
	# Aplica la escala al objeto
	$Sprite3D.scale = Vector3(scale_factor, scale_factor, scale_factor)


func CamaraBlend():
	$AnimationPlayer.play("fadeout")
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(Camara_Jugador,"global_transform",PuzzlePos.global_transform,1)
	tween.connect("finished", on_tween_finished)
	
	
func on_tween_finished():
	get_tree().change_scene_to_file(EscenaACargar)

