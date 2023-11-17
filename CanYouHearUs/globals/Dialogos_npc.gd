extends Node

#hay que añadir el numero de la varibale historia en el que esta el NPC, por ejemplo "historia actual1", "historia actual2"
var rutasNpc = {
	"npc01":{
		"historia actual1":1,
		"texto al que ir1":3
	}
}

var dialogos ={
	"npc01": ['NPC_1_LINE_1',#0
	'NPC_1_LINE_2',#1
	'Cada vez mas texto para añadir.',#2
	'Dime si o no',#3
	'SI dijiste si',#4
	'No dijiste NO',#5
	'Esto no deberia verse',#6
	'Acá hay tres preguntas sobre mi',#7
	'Como me llamo?',#8
	'La segunda cosa sobre mi',#9
	'La tercera cosa sobre mi',#10
	'Sabes muchas cosas sobre mi',#11
	'Entonces quieres una quest de mi parte?',#12
	'Que poderoso saber eso, asi que avanzaremos la historia',#13
	'Parece que no tienes nada aun',#14
	'Tienes lo que te pedi',#15
	'-fin linea-'
		
	],
	"npc02": ['Segundo NPC02 aaaa',#0
	'sssaaa',#1
	'Cada vez mas texto para añadir.',#2
	'Dime si o no',#3
	'SI dijiste si',#4
	'No dijiste NO',#5
	'Esto no deberia verse',#6
	'Acá hay tres preguntas sobre mi',#7
	'Como me llamo?',#8
	'La segunda cosa sobre mi',#9
	'La tercera cosa sobre mi',#10
	'Sabes muchas cosas sobre mi',#11
	'Entonces quieres una quest de mi parte?',#12
	'Que poderoso saber eso, asi que avanzaremos la historia',#13
	'Parece que no tienes nada aun',#14
	'Tienes lo que te pedi',#15
	'-fin linea-'
		
	]
}

func _process(_delta):
	#actualizarDialogosParaAgregarNombres()
	pass

func actualizarDialogosParaAgregarNombres():
	dialogos["npc01"][0] = 'David:  Hola este es un dialogo de prueba y me llamo ' +Globals.NombreProta
