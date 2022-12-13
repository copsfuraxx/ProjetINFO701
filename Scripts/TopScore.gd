extends Control

func _ready():
	var json = get_node("/root/Main").json
	for score in json:
		var label = Label.new()
		label.rect_size.x = rect_size.x
		label.align = Label.ALIGN_CENTER
		label.text = score["nom"] +" score : " + String(score["top_score"])
		label.add_font_override("font", preload("res://Assets/PixelFont.tres"))
		$VBoxContainer.add_child(label)


func _on_Button_pressed():
	var _ignored = get_tree().change_scene("res://Scenes/GUI/MainMenu.tscn")
