extends Card
class_name PNJCard

var vie:int

func _init(id:int = -1, cardName:String = "none", cost:int = 0, _vie:int = 0):
	._init(id, cardName, cost)
	vie = _vie
