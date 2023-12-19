extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://lvls/main_menu.tscn")
