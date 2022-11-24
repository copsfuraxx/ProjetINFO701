extends Control

func _ready():
	var json = get_node("/root/Main").json
	for score in json:
		var label = Label.new()
		label.text = score["nom"] +" score : " + String(score["top_score"])
		$VBoxContainer.add_child(label)
