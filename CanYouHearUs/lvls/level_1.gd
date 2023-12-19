extends Node3D

var texto : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.ModoPlay = true
	Globals.PickiUnTexto = false
	
	if Globals.npc_historias["npc03"] == 1:
		$Triggers/Escena_01.queue_free()
		$Personaje_01.hide()
	if Globals.historia == 7:
		$Personaje_01.hide()
		$Barrera/FenceSeperateBroken.hide()
		$Barrera/StaticBody3D.global_position = Vector3(-14.756,0,11.033)
	elif Globals.historia == 8:
		$Personaje_01/AnimationPlayer.play("03")
		$Barrera/FenceSeperateBroken.hide()
		$Barrera/StaticBody3D.global_position = Vector3(-14.756,0,11.033)
	elif Globals.historia == 9:
		$Portal.queue_free()
		$Personaje_01/AnimationPlayer.play("03")
		$Barrera/FenceSeperateBroken.hide()
		$Barrera/StaticBody3D.global_position = Vector3(-14.756,0,11.033)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(Globals.ModoPlay)
	#print(texto)
	if Input.is_action_just_pressed("Clickear") and $Texto.visible and !Globals.ModoInventario and !Globals.ModoOpciones and texto == 1:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_2" #911, habla Martha en que podemos ayudarla?
		$Texto/AnimationPlayer.play("Texto")
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "REPLY_LINE_1" #Mi amiga se volvio loca he intenta asesinarme
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "REPLY_LINE_2" #Necesito ayuda, por favor, manden ayuda.
		$Acciones_mic.show()
		texto +=1
	elif Input.is_action_just_pressed("Clickear") and $Texto.visible and !Globals.ModoInventario and !Globals.ModoOpciones and texto == 5:
		$Texto.hide()
		texto +=1 #quedamos en texto 6 sumando esta linea
	elif Input.is_action_just_pressed("Clickear") and $Texto.visible and !Globals.ModoInventario and !Globals.ModoOpciones and texto == 0:
		
		$Texto.hide()
	

func _on_escena_01_body_entered(body):
	if body.is_in_group("Jugador"):
		$Personaje_01/AnimationPlayer.play("01")
		$Triggers/Escena_01.queue_free()
		Globals.npc_historias["npc03"] = 1


func _on_text_item_3_tome_item():
	$Texto.show()
	$Texto/Label.visible_ratio = 0
	$Texto/Label.text = "WHERE_SHE_GO_1" #Debo apagar la linterna rapido... Por la ventana, hacia donde va Anna? Se fue por la izquierda, que habrá allá?
	$Texto/AnimationPlayer.play("Texto")
	$Personaje_01/AnimationPlayer.play("02")
	Globals.historia = 7


func _on_base_puzzle_02_01_victoria_puzzle_2():
	if Globals.historia == 7:
		$Puzzle/AnimationPlayer.play("anim_puzzle")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "anim_puzzle" and Globals.historia == 7:
		Globals.historia = 8
		$Puzzle/AnimationPlayer.queue_free()


func _on_text_item_4_tome_item():
	$Texto.show()
	$Texto/Label.visible_ratio = 0
	$Texto/Label.text = "HELP_LINE_1" #deberia llamar al 911 por ayuda, mi amiga esta vuelta loca.
	$Texto/AnimationPlayer.play("Texto")
	texto +=1


func _on_acciones_mic_accion_1_completada():
	if texto == 2:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_3" #Por favor calmese, necesito que respire y me diga si se encuentra en un lugar a salvo.
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "REPLY_LINE_3" #Si... lo estoy, pero no sé que hacer. Ella esta dehabulando por la zona y creo que planea matarme...
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "REPLY_LINE_4" #Si, por favor manden ayuda, la necesito lo más pronto posible!!
	elif texto == 3:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_5" #Ahora necesito que me digas tu dirección y enviaremos la ayuda.
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "REPLY_LINE_5" #No... no sé donde estoy! Como... Como quieres que sepa?...
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "REPLY_LINE_6" #No lo se... tal vez dentro de la casa haya información.
	elif texto == 4:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_6" #Necesito que me des cualquier tipo de información de donde estas...
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Personaje_01/AnimationPlayer.play("03")
		$Acciones_mic.hide()
		
func _on_acciones_mic_accion_2_completada():
	if texto == 2:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_4" #Por favor, necesito que se calme y digame si esta en un lugar a salvo.
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "REPLY_LINE_3" #Si... lo estoy, pero no sé que hacer. Ella esta dehabulando por la zona y creo que planea matarme...
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "REPLY_LINE_4" #Si, por favor manden ayuda, la necesito lo más pronto posible!!
	elif texto == 3:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_5" #Ahora necesito que me digas tu dirección y enviaremos la ayuda.
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Acciones_mic/VBoxContainer/Accion1/Label.text = "REPLY_LINE_5" #No... no sé donde estoy! Como... Como quieres que sepa?...
		$Acciones_mic/VBoxContainer/Accion2/Label.text = "REPLY_LINE_6" #No lo se... tal vez dentro de la casa haya información.
	elif texto == 4:
		$Texto/Label.visible_ratio = 0
		$Texto/Label.text = "HELP_LINE_6" #Necesito que me des cualquier tipo de información de donde estas...
		$Texto/AnimationPlayer.play("Texto")
		texto +=1
		$Personaje_01/AnimationPlayer.play("03")
		$Acciones_mic.hide()



func _on_text_item_5_tome_item():
	$Portal.queue_free()
	$Texto.show()
	$Texto/Label.visible_ratio = 0
	$Texto/Label.text = "HELP_LINE_7" #Debo salir de acá, ella podría escucharme
	$Texto/AnimationPlayer.play("Texto")
	texto = 5
	Globals.historia = 9

func _on_derrota_anim_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://lvls/game_over.tscn")


func _on_personaje_01_jugador_perdio():
	$DerrotaAnim.play("end")


func _on_portal_endgame_body_entered(body):
	if body.is_in_group('Jugador') and Globals.historia == 9:
		transportacion.call_deferred()

func transportacion():
	get_tree().change_scene_to_file("res://lvls/level_final.tscn")
