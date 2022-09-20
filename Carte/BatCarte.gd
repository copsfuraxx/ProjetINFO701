extends Card
class_name BatCard

var vie:int

func _init(id:int = -1, cardName:String = "none", cost:int = 0, _vie:int = 0):
	._init(id, cardName, cost)
	vie = _vie

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
