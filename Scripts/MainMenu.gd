extends Control

func _on_Button_pressed():
	var _ignore = get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Button2_pressed():
	$HTTPRequest.request("http://localhost:3000/TOP_SCORE")

func _on_request_completed(_result, _response_code, _headers, body):
	get_node("/root/Main").json = JSON.parse(body.get_string_from_utf8()).result
	var _ignore = get_tree().change_scene("res://Scenes/GUI/TopScore.tscn")
