extends Control

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Button2_pressed():
	$HTTPRequest.request("http://localhost:3000/TOP_SCORE")

func _on_request_completed(result, response_code, headers, body):
	get_node("/root/Main").json = JSON.parse(body.get_string_from_utf8()).result
	get_tree().change_scene("res://Scenes/GUI/TopScore.tscn")
