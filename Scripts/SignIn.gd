extends Control

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "err":
		$PopupDialog/Label.text = "Error"
		$PopupDialog.popup_centered(get_viewport_rect().size/2)

func _on_Button_pressed():
	$HTTPRequest.request("http://localhost:3000/INSERT_USER?nom=" + $LineEdit.text)
