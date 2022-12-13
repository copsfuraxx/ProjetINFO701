extends Card
class_name PNJCard
#Class pour structurer les données des cartes pour "l'invocation" de pnj

var nbr:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", _nbr:int = 0).(id, cardName, cost, img):
	nbr = _nbr
