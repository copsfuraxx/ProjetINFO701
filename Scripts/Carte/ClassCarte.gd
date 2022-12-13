class_name Card
#Class abstraite pour structurer les données des cartes

var id:int
var cardName:String
var cost:int
var img:String

func _init(_id:int = -1, _cardName:String = "null", _cost:int = 0, _img:String = "null"):
	id = _id
	cardName = _cardName
	cost = _cost
	img = _img
