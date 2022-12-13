extends BatCard
class_name ProdBatCarte
#Class pour structurer les données des cartes de batiment de production

const Food = 0
const Build = 1

var prod:int
var qtt:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", worker:int = 0, vie:int = 0, _prod:int = -1, _qtt:int = 0).(id, cardName, cost, img, worker, vie):
	prod = _prod
	qtt = _qtt
