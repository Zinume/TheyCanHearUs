extends Node2D



func _ready():
	Globals.ModoPlay = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	coneccionesAudio()

func _on_load_pressed():
	if FileAccess.file_exists("user://save_game.dat"): 
		Globals.AcaboDeCargar = true
		Globals.cargar()
		get_tree().change_scene_to_file(Globals.infoJugador["escenaACargar"])


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://lvls/main_menu.tscn")

func click():
	$Click.play()
	
func coneccionesAudio():
	$ColorRect/VBoxContainer/Load.mouse_entered.connect(click)
	$ColorRect/VBoxContainer/Exit.mouse_entered.connect(click)
