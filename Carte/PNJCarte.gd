extends Card
class_name PNJCard

var nbr:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, _nbr:int = 0, _img:String = "null"):
	._init(id, cardName, cost, _img)
	nbr = _nbr
