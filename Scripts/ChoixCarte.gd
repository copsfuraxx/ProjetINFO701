extends Spatial

var path = "res://Cartes.json"
var deck:Array = []
onready var scene = preload("res://Scenes/Carte.tscn")

func _ready():
	var data_file = File.new()
	if data_file.open(path, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	var data = data_parse.result
	var id = 0
	
	for carte in data:
		if(carte["type"] == "pnj"):
			for _i in range(carte["nbrCarte"]):
				deck.append(PNJCard.new(id, carte["name"], carte["cost"], carte["img"], carte["nbr"]))
		elif(carte["type"] == "prod"):
			for _i in range(carte["nbrCarte"]):
				deck.append(ProdBatCard.new(id, carte["name"], carte["cost"], carte["img"], carte["worker"], carte["vie"], carte["prod"], carte["qtt"]))
		elif(carte["type"] == "fight"):
			for _i in range(carte["nbrCarte"]):
				deck.append(ProdBatCard.new(id, carte["name"], carte["cost"], carte["img"], carte["worker"], carte["vie"], carte["degat"]))
		elif(carte["type"] == "event"):
			for _i in range(carte["nbrCarte"]):
				deck.append(EventCard.new(id, carte["name"], carte["cost"]))
		id += 1
	get_node("/root/Main").deck = deck
	randomize()
	deck.shuffle()
	var x = -0.6
	for _i in range(3):
		var c = scene.instance()
		c.setCard(deck[0], x, -1.25)
		deck.remove(0)
		x+= 0.6
		$"../".call_deferred("add_child", c)
	queue_free()
	#$"../".call_deferred("remove_child", self)
