extends Spatial

var path = "res://Cartes.json"
var deck: Array = []

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
			deck.append(PNJCard.new(id, carte["name"], carte["cost"], carte["vie"]))
		elif(carte["type"] == "bat"):
			deck.append(BatCard.new(id, carte["name"], carte["cost"], carte["vie"]))
		elif(carte["type"] == "event"):
			deck.append(BatCard.new(id, carte["name"], carte["cost"]))
		id += 1
		
	for carte in data:
		print_debug(carte)
