extends Control

#negativo se muestra Diario y positivo Items


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	visibilidad()
	

func _input(event):
	
	if event.is_action_pressed("ui_inventario"):
		if Globals.ModoInventario and !Globals.PickiUnTexto:
			Globals.ModoInventario = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif Globals.ModoInventario and Globals.PickiUnTexto:
			Globals.ModoInventario = false
		else:
			checkearInventario()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Globals.ModoInventario = true
			
			
		
func visibilidad():
	if Globals.ModoInventario and !Globals.ModoOpciones:
		show()
	else:
		hide()

func categorias_inventario():
	if !Globals.CualCategoria and Globals.ModoInventario:
		$DiariosSeccion.show()
		$ItemsSeccion.hide()
	elif Globals.CualCategoria and Globals.ModoInventario:
		$DiariosSeccion.hide()
		$ItemsSeccion.show()


func _on_diario_pressed():
	$Label.show()
	Globals.CualCategoria = false
	categorias_inventario()
	$ItemDescripcion.hide()

func _on_items_pressed():
	$Label.hide()
	Globals.CualCategoria = true
	categorias_inventario()
	$ItemDescripcion.show()

#### Diarios

func _on_diario_1_pressed():
	$Label.set_text(Inventario.contenidoDiario["diario"]["diario1"])


func _on_diario_2_pressed():
	$Label.set_text(Inventario.contenidoDiario["diario"]["diario2"])


func _on_diario_3_pressed():
	$Label.set_text(Inventario.contenidoDiario["diario"]["diario3"])


func _on_diario_4_pressed():
	$Label.set_text(Inventario.contenidoDiario["diario"]["diario4"])


func _on_diario_5_pressed():
	$Label.set_text(Inventario.contenidoDiario["diario"]["diario5"])

###Items




func _on_item_1_pressed():
	$ItemDescripcion/Label.set_text(Inventario.contenidoItem["item"]["item1"])


func _on_item_2_pressed():
	$ItemDescripcion/Label.set_text(Inventario.contenidoItem["item"]["item2"])


func _on_item_3_pressed():
	$ItemDescripcion/Label.set_text(Inventario.contenidoItem["item"]["item3"])


func _on_item_4_pressed():
	$ItemDescripcion/Label.set_text(Inventario.contenidoItem["item"]["item4"])


func _on_item_5_pressed():
	$ItemDescripcion/Label.set_text(Inventario.contenidoItem["item"]["item5"])


func checkearInventario():
	if Globals.infoJugador["inventario"]["item1"] == true:
		$ItemsSeccion/Item1.show()
	else:
		$ItemsSeccion/Item1.hide()
		
	if Globals.infoJugador["inventario"]["item2"] == true:
		$ItemsSeccion/Item2.show()
	else:
		$ItemsSeccion/Item2.hide()
		
	if Globals.infoJugador["inventario"]["item3"] == true:
		$ItemsSeccion/Item3.show()
	else:
		$ItemsSeccion/Item3.hide()
		
	if Globals.infoJugador["inventario"]["item4"] == true:
		$ItemsSeccion/Item4.show()
	else:
		$ItemsSeccion/Item4.hide()
		
	if Globals.infoJugador["inventario"]["item5"] == true:
		$ItemsSeccion/Item5.show()
	else:
		$ItemsSeccion/Item5.hide()

	if Globals.infoJugador["inventario"]["diario1"] == true:
		$DiariosSeccion/Diario1.show()
	else:
		$DiariosSeccion/Diario1.hide()
		
	if Globals.infoJugador["inventario"]["diario2"] == true:
		$DiariosSeccion/Diario2.show()
	else:
		$DiariosSeccion/Diario2.hide()
	
	if Globals.infoJugador["inventario"]["diario3"] == true:
		$DiariosSeccion/Diario3.show()
	else:
		$DiariosSeccion/Diario3.hide()
		
	if Globals.infoJugador["inventario"]["diario4"] == true:
		$DiariosSeccion/Diario4.show()
	else:
		$DiariosSeccion/Diario4.hide()
		
	if Globals.infoJugador["inventario"]["diario5"] == true:
		$DiariosSeccion/Diario5.show()
	else:
		$DiariosSeccion/Diario5.hide()
