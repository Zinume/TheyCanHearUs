extends CanvasLayer
### Guia: Preguntas01 al preguntas04 son la cantidad de bloques para preguntar, debes llamar 
#	al que necesites. luego en el array debes añadir la linea, empiezas desde el 0 en todos los array
var JugadorDentro = false
var ModoElecciones = false
var ModoPreguntas = false
var CualNPCSoy = 'npc01'
var TextoPersonaje00 = 0
var EstoyEscribiendo = false
@onready var Lvl = get_parent()
#@export var NPC_sprites : CanvasLayer


var TextoEdit = ''
var PresioneEnterEdit = false

signal fin_de_dialogo

var SignalBoton1 = false
var SignalBoton2 = false
var SignalPregunta01 = false
var SignalPregunta02 = false
var SignalPregunta03 = false
var SignalPregunta04 = false

var VolverMenu:Array = [
	{
		"Dialogo_Actual": 8,
		"Menu_al_que_ir": 7,
	},
	{
		"Dialogo_Actual": 9,
		"Menu_al_que_ir": 7,
	},
	{
		"Dialogo_Actual": 221,
		"Menu_al_que_ir": 122,
	}
]


func _ready():
	pass
	#CheckSprite()
	
# warning-ignore:unused_argument
func _process(_delta):
	
	######		DIALOGO NPC 01		################
	#if JugadorDentro and Input.is_action_just_pressed("ui_chat") and !Global.ModoChat and NPC == CualNPCSoy and TextoPersonaje00 == 0:
	#	ActualizarDialogosConTextoModificado()
	#	CheckRutaHistoria()
	#	ChatBox_activado()
	#	CambiarSpriteNPC('Player')
	#	Setear_text(DialogosNPC00[TextoPersonaje00])
	#	AnimacionTexto()
	#	if TextoPersonaje00 in NpcArrays.AgregarTexto[CualNPCSoy] and !EstoyEscribiendo:
	#		EstoyEscribiendo = true
	#		NecesitoEscribir()

	if Globals.ModoChat and Input.is_action_just_pressed("ui_chat") and !Globals.ModoOpciones and !EstoyEscribiendo and $CanvasLayer/Label.visible_ratio == 1 and TextoPersonaje00 < DialogosNpc.dialogos[CualNPCSoy].size():
			
		#Acá estan los textos en donde se recompensa para avanza en la historia
		if TextoPersonaje00 in NpcArrays.TextoRecompensa[CualNPCSoy]:
			Globals.npc_historias[CualNPCSoy] += 1
		#acá es para añadir historia a otros NPC
		if TextoPersonaje00 in DialogosNpc.rutasParaOtrosNpc[CualNPCSoy]:
			agregarHistoriaAOtrosNpc(DialogosNpc.rutasParaOtrosNpc[CualNPCSoy][TextoPersonaje00])
		else:
			pass
			
		### Añadir hora al dia
		#if TextoPersonaje00 in NpcArrays.HoraDelDia[CualNPCSoy]:
			#Lvl.AgregarHora()
			
	#Finales de conversacion en las diferentes lineas de dialogo
		if TextoPersonaje00 in NpcArrays.FinalesDialogos[CualNPCSoy]:
			print('termine')
			fin_de_dialogo.emit()
			TextoPersonaje00 = 0
			ChatBox_desactivado()
			
	#Para volver al menu de preguntas, hay que restarle 1 por que sino no funciona... pon el numero donde esta el menu
		if TextoPersonaje00 in NpcArrays.VolverAlMenuPreguntas[CualNPCSoy]:
			for Menu in NpcArrays.VolverMenu[CualNPCSoy]:
				if Menu["Dialogo_Actual"] == TextoPersonaje00:
					TextoPersonaje00 = Menu["Menu_al_que_ir"] -1
					break
	################################################################
	#Flujo de Dialogos normales en su ruta
		if Globals.ModoChat and !ModoElecciones and !ModoPreguntas:
			TextoPersonaje00 += 1
			Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
			AnimacionTexto()
			# Si hay elecciones de si y no. Donde será:
			if !ModoElecciones and TextoPersonaje00 in NpcArrays.PreguntaSiyNo[CualNPCSoy]:
				ModoEleccionesSiyNO()
			if !ModoPreguntas and !ModoElecciones and TextoPersonaje00 in NpcArrays.Preguntas01[CualNPCSoy]:
				NecesitoPreguntas01()
				SetearTextoPreguntas01(NpcArrays.setearTextoPregunta01[CualNPCSoy][TextoPersonaje00])
			if !ModoPreguntas and !ModoElecciones and TextoPersonaje00 in NpcArrays.Preguntas02[CualNPCSoy]:
				NecesitoPreguntas02()
				SetearTextoPreguntas02(NpcArrays.setearTextoPregunta01[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta02[CualNPCSoy][TextoPersonaje00])
			if !ModoPreguntas and !ModoElecciones and TextoPersonaje00 in NpcArrays.Preguntas03[CualNPCSoy]:
				NecesitoPreguntas03()
				SetearTextoPreguntas03(NpcArrays.setearTextoPregunta01[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta02[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta03[CualNPCSoy][TextoPersonaje00])
			if !ModoPreguntas and !ModoElecciones and TextoPersonaje00 in NpcArrays.Preguntas04[CualNPCSoy]:
				NecesitoPreguntas04()
				SetearTextoPreguntas04(NpcArrays.setearTextoPregunta01[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta02[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta03[CualNPCSoy][TextoPersonaje00],NpcArrays.setearTextoPregunta04[CualNPCSoy][TextoPersonaje00])
			# Caja de texto para escribire
			if TextoPersonaje00 in NpcArrays.AgregarTexto[CualNPCSoy] and !EstoyEscribiendo:
				EstoyEscribiendo = true
				NecesitoEscribir()
	# Si llegaste al final de los dialogos, se termina el chat
		if TextoPersonaje00 == DialogosNpc.dialogos[CualNPCSoy].size()-1:
			fin_de_dialogo.emit()
			TextoPersonaje00 = 0
			ChatBox_desactivado()

#ENCUENTRO CON EL NPC 01

##################
#func _on_Area2D_body_entered(body):
#	if body.is_in_group('jugador'):
#		JugadorDentro = true
#		NPC = CualNPCSoy
		
		
#func _on_Area2D_body_exited(body):
#	if body.is_in_group('jugador'):
#		JugadorDentro = false
		
		
########## SALIDA NPC01 #########


############# FUNCIONES ###############

func ModoEleccionesSiyNO():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ModoElecciones = true
	$CanvasLayer/VBoxContainer2/Boton1.grab_focus()
	$CanvasLayer/VBoxContainer2/Boton1.show()
	$CanvasLayer/VBoxContainer2/Boton2.show()
	if TextoPersonaje00 in NpcArrays.PreguntaSiyNo[CualNPCSoy]:
		$CanvasLayer/VBoxContainer2/Boton1.set_text('Yes')
		$CanvasLayer/VBoxContainer2/Boton2.set_text('No')


func ModoElecciones_desactivado():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ModoElecciones = false
	$CanvasLayer/VBoxContainer2/Boton1.hide()
	$CanvasLayer/VBoxContainer2/Boton2.hide()
	

#######################

func NecesitoPreguntas01():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ModoPreguntas = true
	$CanvasLayer/VBoxContainer/Pregunta01.grab_focus()
	$CanvasLayer/VBoxContainer/Pregunta01.show()
	
func SetearTextoPreguntas01(PrimeraPregunta:String):
		$CanvasLayer/VBoxContainer/Pregunta01.set_text(PrimeraPregunta)

func NecesitoPreguntas02():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ModoPreguntas = true
	$CanvasLayer/VBoxContainer/Pregunta01.grab_focus()
	$CanvasLayer/VBoxContainer/Pregunta01.show()
	$CanvasLayer/VBoxContainer/Pregunta02.show()
	
func SetearTextoPreguntas02(PrimeraPregunta:String,SegundaPregunta:String):
		$CanvasLayer/VBoxContainer/Pregunta01.set_text(PrimeraPregunta)
		$CanvasLayer/VBoxContainer/Pregunta02.set_text(SegundaPregunta)
	

func NecesitoPreguntas03():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ModoPreguntas = true
	$CanvasLayer/VBoxContainer/Pregunta01.grab_focus()
	$CanvasLayer/VBoxContainer/Pregunta01.show()
	$CanvasLayer/VBoxContainer/Pregunta02.show()
	$CanvasLayer/VBoxContainer/Pregunta03.show()
	
func SetearTextoPreguntas03(PrimeraPregunta:String,SegundaPregunta:String,TerceraPregunta:String):
		$CanvasLayer/VBoxContainer/Pregunta01.set_text(PrimeraPregunta)
		$CanvasLayer/VBoxContainer/Pregunta02.set_text(SegundaPregunta)
		$CanvasLayer/VBoxContainer/Pregunta03.set_text(TerceraPregunta)
	
func NecesitoPreguntas04():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ModoPreguntas = true
	$CanvasLayer/VBoxContainer/Pregunta01.grab_focus()
	$CanvasLayer/VBoxContainer/Pregunta01.show()
	$CanvasLayer/VBoxContainer/Pregunta02.show()
	$CanvasLayer/VBoxContainer/Pregunta03.show()
	$CanvasLayer/VBoxContainer/Pregunta04.show()
	
func SetearTextoPreguntas04(PrimeraPregunta:String,SegundaPregunta:String,TerceraPregunta:String,CuartaPregunta:String):
		$CanvasLayer/VBoxContainer/Pregunta01.set_text(PrimeraPregunta)
		$CanvasLayer/VBoxContainer/Pregunta02.set_text(SegundaPregunta)
		$CanvasLayer/VBoxContainer/Pregunta03.set_text(TerceraPregunta)
		$CanvasLayer/VBoxContainer/Pregunta04.set_text(CuartaPregunta)
	
func NecesitoPreguntas_desactivado():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ModoPreguntas = false
	$CanvasLayer/VBoxContainer/Pregunta01.hide()
	$CanvasLayer/VBoxContainer/Pregunta02.hide()
	$CanvasLayer/VBoxContainer/Pregunta03.hide()
	$CanvasLayer/VBoxContainer/Pregunta04.hide()
	
	
func NecesitoEscribir():
	$CanvasLayer/VBoxContainer/LineEdit.show()


func NecesitoEscribir_desactivado():
	$CanvasLayer/VBoxContainer/LineEdit.hide()

func Setear_text(TEXTO: String):
	$CanvasLayer/Label.text = tr(TEXTO)


func AnimacionTexto():
	$CanvasLayer/Label.visible_ratio = 0
	$CanvasLayer/AnimationPlayer.play("SetAnim_Text")

func ChatBox_activado():
	$CanvasLayer.show()
	#get_tree().paused = true
	Globals.ModoChat = true
	#CheckSprite()


func ChatBox_desactivado():
	$CanvasLayer/Label.visible_ratio = 0
	$CanvasLayer.hide()
	#get_tree().paused = false
	Globals.ModoChat = false
	#CheckSprite()
	


############### Botones
func _on_Boton1_pressed():
	SignalBoton1 = true
	$Timer.start()
	ModoElecciones_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnSiYNo[CualNPCSoy]["boton1"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()
	

func _on_Boton2_pressed():
	SignalBoton2 = true
	$Timer.start()
	ModoElecciones_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnSiYNo[CualNPCSoy]["boton2"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()


func _on_Pregunta01_pressed():
	SignalPregunta01 = true
	$Timer.start()
	NecesitoPreguntas_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnPregunta[CualNPCSoy]["pregunta1"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()

	

func _on_Pregunta02_pressed():
	SignalPregunta02 = true
	$Timer.start()
	NecesitoPreguntas_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnPregunta[CualNPCSoy]["pregunta2"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()
	
	
func _on_Pregunta03_pressed():
	SignalPregunta03 = true
	$Timer.start()
	NecesitoPreguntas_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnPregunta[CualNPCSoy]["pregunta3"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()

func _on_Pregunta04_pressed():
	SignalPregunta04 = true
	$Timer.start()
	NecesitoPreguntas_desactivado()
	TextoPersonaje00 = NpcBotones.historiaIrEnPregunta[CualNPCSoy]["pregunta4"][TextoPersonaje00]
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()

##Aca se añade el texto
func _on_LineEdit_text_entered(new_text):
	Globals.NombreProta = new_text
	EstoyEscribiendo = false
	TextoPersonaje00 += 1
	Setear_text(DialogosNpc.dialogos[CualNPCSoy][TextoPersonaje00])
	AnimacionTexto()
	$CanvasLayer/VBoxContainer/LineEdit.set_text('Click to Edit')
	NecesitoEscribir_desactivado()
	


func _on_LineEdit_focus_entered():
	$CanvasLayer/VBoxContainer/LineEdit.clear()
	

##checkear requisitos para continuar cada ruta y seguir la misma
func CheckRutaHistoria(Npc: String):
	if Globals.npc_historias[Npc] == 0:
		pass
	elif DialogosNpc.rutasNpc[Npc]["historia actual"+str(Globals.npc_historias[Npc])] == Globals.npc_historias[Npc]:
		TextoPersonaje00 = DialogosNpc.rutasNpc[Npc]["texto al que ir"+str(Globals.npc_historias[Npc])]
		

<<<<<<< Updated upstream
#func CheckSprite():
#	if Globals.ModoChat:
#		NPC_sprites.get_node("AnimatedSprite1").show() 
#	else:
#		NPC_sprites.get_node("AnimatedSprite1").hide()
#		NPC_sprites.DetenerAnimacion()


#func CambiarSpriteNPC(NombreNPC):
#	NPC_sprites.get_node("AnimatedSprite1").animation = NombreNPC
	
	
=======
func agregarHistoriaAOtrosNpc(NpcAjeno:String):
	Globals.npc_historias[NpcAjeno]+= 1
>>>>>>> Stashed changes

func TimerParaCambiarEstadoPreguntas():
	SignalPregunta01 = false
	SignalPregunta02 = false
	SignalPregunta03 = false
	SignalPregunta04 = false
	SignalBoton1 = false
	SignalBoton2 = false
	


func _on_timer_timeout():
	TimerParaCambiarEstadoPreguntas()
