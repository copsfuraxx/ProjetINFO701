extends BatCard
class_name FightBatCard

var degat:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", worker:int = 0, vie:int = 0, _degat:int = 0):
	._init(id, cardName, cost, img, worker, vie)
	degat = _degat
