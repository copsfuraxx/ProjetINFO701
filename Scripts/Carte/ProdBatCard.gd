extends BatCard
class_name ProdBatCard

const Food = 0
const Build = 1

var prod:int
var qtt:int

func _init(id:int = -1, cardName:String = "null", cost:int = 0, img:String = "null", worker:int = 0, vie:int = 0, _prod:int = -1, _qtt:int = 0):
	._init(id, cardName, cost, img, worker, vie)
	prod = _prod
	qtt = _qtt
