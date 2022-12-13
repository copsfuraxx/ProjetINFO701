extends BatCard
class_name FightBatCarte
#Class pour structurer les données des cartes de batiment de combat

var degat:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", worker:int = 0, vie:int = 0, _degat:int = 0).(id, cardName, cost, img, worker, vie):
	degat = _degat
