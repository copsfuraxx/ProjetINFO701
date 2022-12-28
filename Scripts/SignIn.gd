extends Control

onready var main = get_node("/root/Main")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "err":
		$PopupDialog/Label.text = "Error"
		$PopupDialog.popup_centered(get_viewport_rect().size/2)
	else:
		main.joueur = $LineEdit.text
	var _ignored = get_tree().change_scene("res://Scenes/Main.tscn")

func _on_Button_pressed():
	$HTTPRequest.request("http://" + main.ip + ":3000/INSERT_USER?nom=" + $LineEdit.text)
