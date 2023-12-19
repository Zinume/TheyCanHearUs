extends Node

#hay que añadir el numero de la varibale historia en el que esta el NPC, por ejemplo "historia actual1", "historia actual2"
var rutasNpc = {
	"npc01":{
		"historia actual1":1,
		"texto al que ir1":3
	},
	"npc02":{
		"historia actual1":1,
		"texto al que ir1":4
	}
}

#primero va el texto o linea que se esta leyendo y luego al NPC que tendrá la suma
var rutasParaOtrosNpc = {
	"npc02":{
		
	},
	"npc03":{
		3:"npc02"
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
	"npc02": ['NPC_2_LINE_1',#0
	'NPC_2_LINE_2',#1
	'NPC_2_LINE_3',#2
	'NPC_2_LINE_4',#3
	'NPC_2_LINE_5',#4
	'NPC_2_LINE_6',#5
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
	"npc03": ['NPC_3_LINE_1',#0
	'NPC_3_LINE_2',#1
	'NPC_3_LINE_3',#2
	'NPC_3_LINE_4',#3
	'NPC_3_LINE_5',#4
	'NPC_3_LINE_6',#5
	'NPC_3_LINE_7',#6
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
