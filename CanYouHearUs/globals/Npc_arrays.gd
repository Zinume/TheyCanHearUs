extends Node

#Esta constante es para saber que dialogos necesitan Si y No en sus botones
var PreguntaSiyNo = {
	"npc01":[3],
	"npc02":[],
	"npc03":[],
} 
#Esta constante es para saber donde estará las preguntas con 1 numero
const Preguntas01= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 
#Esta constante es para saber donde estará las preguntas con 3 numero
const Preguntas02= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 

#Esta constante es para saber donde estará las preguntas con 3 numero
const Preguntas03= {
	"npc01":[7],
	"npc02":[],
	"npc03":[],
} 
#Esta constante es para saber donde estará las preguntas con 4 numero
const Preguntas04= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 
#Hay que poner primero el dialogo donde estan las preguntas y luego las seteara. Ejmplo:
#"npc01":{
#		7:"Primera Pregunta"
#	}
#}
const setearTextoPregunta01 ={
	"npc01":{
		7:"QUESTION_1"
	}
}
const setearTextoPregunta02 ={
	"npc01":{
		7:"QUESTION_2"
	}
}
const setearTextoPregunta03 ={
	"npc01":{
		7:"QUESTION_3"
	}
}
const setearTextoPregunta04 ={
	"npc01":{
		7:"QUESTION_4"
	}
}

var VolverAlMenuPreguntas= {
	"npc01":[4,9,10],
	"npc02":[],
	"npc03":[],
} 
#Textos donde termina el dialogo
var FinalesDialogos= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 

#Esta constante es para cambiar la hora del dia de cada NPC.
const HoraDelDia= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 

const AgregarTexto= {
	"npc01":[],
	"npc02":[3],
	"npc03":[],
} 

const TextoRecompensa= {
	"npc01":[],
	"npc02":[],
	"npc03":[],
} 


var VolverMenu = {
	"npc01":[
		{
		"Dialogo_Actual": 4,
		"Menu_al_que_ir": 3,
		},
		{
		"Dialogo_Actual": 5,
		"Menu_al_que_ir": 3,
		},
		{
		"Dialogo_Actual": 9,
		"Menu_al_que_ir": 7,
		},
		{
		"Dialogo_Actual": 10,
		"Menu_al_que_ir": 7,
		},
		{
		"Dialogo_Actual": 11,
		"Menu_al_que_ir": 7,
		}
		]
}
