extends Control

onready var main = get_node("/root/Main")

func _on_Button_pressed():
	var _ignored = get_tree().change_scene("res://Scenes/GUI/SignIn.tscn")

func _on_Button2_pressed():
	$HTTPRequest.request("http://" + main.ip + ":3000/TOP_SCORE")

func _on_Button3_pressed():
	if $"VBoxContainer/LineEdit".text.length() >= 7:
		main.ip = $VBoxContainer/LineEdit.text

func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body):
	main.json = JSON.parse(body.get_string_from_utf8()).result
	var _ignored = get_tree().change_scene("res://Scenes/GUI/TopScore.tscn")
