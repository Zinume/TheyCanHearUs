extends Control


var MeActive = false
@onready var Texto = $Label

# Called when the node enters the scene tree for the first time.
var Activados = 0

func _ready():
	hide()
	# Almacena la cantidad de elementos activados al inicio
	Activados = count_activados()

func _process(_delta):
	meActive()
	# Verificar si algún elemento del inventario se activa
	var activados_ahora = count_activados()

	# Si la cantidad de elementos activados ha cambiado, significa que se activó un nuevo item
	if activados_ahora != Activados:
		Activados = activados_ahora
		print("¡Se activó un nuevo item!")
		MeActive = true

func count_activados():
	var count = 0
	for item in Globals.infoJugador["inventario"].values():
		if item == true:
			count += 1
	return count


func meActive():
	if MeActive == true:
		show()
		$AnimationPlayer.play("desaparecer")
		
	else:
		hide()


func _on_animation_player_animation_finished(_anim_name):
	MeActive = false
