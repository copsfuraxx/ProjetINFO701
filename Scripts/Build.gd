extends StaticBody
#Script qui gère la physique des batiments

signal shoot(dammage)
signal destroy()
const porte = 5.0
var vie:int
var cart:BatCard
var timer:float = 1.0
onready var main = get_node("/root/Main")
var cible:KinematicBody = null

#initialize le batiment
func _ready():
	connect("destroy", get_node("../CameraNuit"), "batDestroy")
	stop()

#gere le combat si le batiment est un batiment de combat
func _physics_process(delta):
	if cart is FightBatCarte:
		if cible == null:
			findCible()
		if cible != null and timer - delta <= .0:
			timer = 1.0
			connect("shoot", cible, "hit", [1])
			emit_signal("shoot")
			disconnect("shoot", cible, "hit")
			cible = null
		else:
			timer -= delta

#lie la carte au batiment
func setCart(c:BatCard):
	vie = c.vie
	cart = c

#fonction appelé quand le batiment prend un coup
func hit(dammage:int):
	if vie - dammage <= 0:
		vie = 0
		dead()
	else:
		vie -= dammage

#fonction appelé quand le batiment n'a plus de vie
func dead():
	stop()
	emit_signal("destroy")
	visible = false
	$CollisionShape.disabled = true

#demare la physique
func start():
	set_physics_process(true)

#arrete la physique
func stop():
	set_physics_process(false)

#fonction qui recherche une cible parmi les zombie sur la map
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

#fonction qui gère la production de ressource
func prod():
	if cart is ProdBatCarte:
		match cart.prod:
			0:
				main.food += cart.qtt
			1:
				main.buildRessource += cart.qtt

#fonction qui repare reset la vie du batiment
func repair():
	if vie == 0:
		visible = true
		$CollisionShape.disabled = false
	vie = cart.vie
