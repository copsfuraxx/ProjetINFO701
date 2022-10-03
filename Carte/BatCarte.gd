extends Card
class_name BatCard

var vie:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, _vie:int = 0, _img:String = "null"):
	._init(id, cardName, cost, _img)
	vie = _vie

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
