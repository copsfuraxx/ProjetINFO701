extends StaticBody

signal shoot(dammage)
signal destroy()
const porte = 5.0
var vie:int
var cart:Card
var timer:float = 1.0
onready var main = get_node("/root/Main")
var cible:KinematicBody = null

func _ready():
	connect("destroy", get_node("../CameraNuit"), "batDestroy")
	stop()

func _physics_process(delta):
	if cart is FightBatCard:
		if cible == null:
			findCible()
		if cible != null and timer - delta <= .0:
			connect("shoot", cible, "hit", [1])
			emit_signal("shoot")
			disconnect("shoot", cible, "hit")
			cible = null
		else:
			timer -= delta

func setCart(c:BatCard):
	vie = c.vie
	cart = c

func hit(dammage:int):
	if vie - dammage <= 0:
		vie = 0
		dead()
	else:
		vie -= dammage

func dead():
	emit_signal("destroy")
	visible = false
	$CollisionShape.disabled = true

func start():
	set_physics_process(true)

func stop():
	set_physics_process(false)

func findCible():
	for z in main.zombies:
		if translation.distance_to(z.translation) <= porte:
			if cible == null:
				cible = z
			else:
				var d1 = translation.distance_to(cible.translation)
				var d2 = translation.distance_to(z.translation)
				if d2 < d1:
					cible = z

func prod():
	if cart is ProdBatCard:
		match cart.prod:
			0:
				main.food += cart.qtt
			1:
				main.buildRessource += cart.qtt
