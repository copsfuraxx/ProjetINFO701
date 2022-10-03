extends MeshInstance

var data:Card = null

func _process(delta):
	if data == null:
		return
