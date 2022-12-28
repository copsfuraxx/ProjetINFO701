extends Control

var main

func _ready():
	main = get_node("/root/Main")

func _process(_delta):
	$Control/Label.text = String(main.population)
	$Control2/Label.text = String(main.buildRessource)
	$Control3/Label.text = String(main.food)
