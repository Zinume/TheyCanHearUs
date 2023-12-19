extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.historia == 10:
		$PosEnemySave.play("01")
	elif Globals.historia == 11:
		$PosEnemySave.play("02")
	elif Globals.historia == 12:
		$PosEnemySave.play("03")
	elif Globals.historia == 13:
		$PosEnemySave.play("04")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


## derrota
func _on_personaje_01_jugador_perdio():
	$DerrotaAnim.play("end")


func _on_derrota_anim_animation_finished(anim_name):
	if anim_name == "end":
		get_tree().change_scene_to_file("res://lvls/game_over.tscn")
	elif anim_name == "ending":
		get_tree().change_scene_to_file("res://lvls/ending.tscn")
##


func _on_zona_1_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/Persecucion.play("01")
		$Zona_1.queue_free()
		cazandoLevelFinal_1()
		Globals.historia = 10

func cazandoLevelFinal_1():
		$Personaje_01.posicionesZonas["zona_1"] = $Posiciones_2/Marker3D.global_position
		$Personaje_01.posicionesZonas["zona_2"] = $Posiciones_2/Marker3D2.global_position
		$Personaje_01.posicionesZonas["zona_3"] = $Posiciones_2/Marker3D3.global_position


func _on_zona_2_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/Persecucion.play("01")
		$Zona_2.queue_free()
		cazandoLevelFinal_2()
		Globals.historia = 11

func cazandoLevelFinal_2():
		$Personaje_01.posicionesZonas["zona_1"] = $Posiciones_3/Marker3D.global_position
		$Personaje_01.posicionesZonas["zona_2"] = $Posiciones_3/Marker3D2.global_position
		$Personaje_01.posicionesZonas["zona_3"] = $Posiciones_3/Marker3D3.global_position


func _on_zona_3_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/Persecucion.play("01")
		$Zona_3.queue_free()
		cazandoLevelFinal_3()
		Globals.historia = 12
	
func cazandoLevelFinal_3():
		$Personaje_01.posicionesZonas["zona_1"] = $Posiciones_4/Marker3D.global_position
		$Personaje_01.posicionesZonas["zona_2"] = $Posiciones_4/Marker3D2.global_position
		$Personaje_01.posicionesZonas["zona_3"] = $Posiciones_4/Marker3D3.global_position


func _on_zona_4_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/Persecucion.play("01")
		$Zona_4.queue_free()
		cazandoLevelFinal_4()
		Globals.historia = 13

func cazandoLevelFinal_4():
		$Personaje_01.posicionesZonas["zona_1"] = $Posiciones_5/Marker3D.global_position
		$Personaje_01.posicionesZonas["zona_2"] = $Posiciones_5/Marker3D2.global_position
		$Personaje_01.posicionesZonas["zona_3"] = $Posiciones_5/Marker3D3.global_position


func _on_zona_5_body_entered(body):
	if body.is_in_group("Jugador"):
		$DerrotaAnim.play("ending")
		$Zona_5.queue_free()
	
