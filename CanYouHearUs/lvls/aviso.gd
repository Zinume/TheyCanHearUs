extends Node2D


func _ready():
	if FileAccess.file_exists("user://save_game.dat"):
		Globals.cargar()
		#saber el idioma guardado
		idioma_item_selected(Globals.opcionesParametros["Idioma"])
		#para hacer fullscreen
		if Globals.is_fullscreen:
			Globals.is_fullscreen = false
			Globals._toggle_fullscreen()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://lvls/main_menu.tscn")

func idioma_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("en")
		Globals.opcionesParametros["Idioma"] = 0
	elif index == 1:
		TranslationServer.set_locale("es")
		Globals.opcionesParametros["Idioma"] = 1
