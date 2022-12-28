extends Node
#Script qui sotck les informations

var population = 10
var buildRessource = 100
var food = 100
var deck:Array
var json
var j:int = 1
var building = []
var zombies = []
var ip = "localhost"
var joueur:String


func reset():
	population = 10
	buildRessource = 100
	food = 100
	deck = []
	json = null
	j = 1
	building = []
	zombies = []
