extends Card
class_name PNJCard

var nbr:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", _nbr:int = 0):
	._init(id, cardName, cost, img)
	nbr = _nbr
