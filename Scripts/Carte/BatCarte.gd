extends Card
class_name BatCard
#Class abstraite pour structurer les données des cartes de batiment

var worker:int
var vie:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", _worker:int = 0, _vie:int = 0).(id, cardName, cost, img):
	worker = _worker
	vie = _vie
