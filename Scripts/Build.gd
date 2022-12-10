extends StaticBody

var vie:int
var cart

func setCart(c:BatCard):
	vie = c.vie
	cart = c

func hit(dammage:int):
	if vie - dammage <= 0:
		dead()
		vie = 0
	else:
		vie -= dammage

func dead():
	visible = false
	$CollisionShape.disabled = true
