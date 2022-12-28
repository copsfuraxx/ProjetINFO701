extends Camera
#Script qui gère la camera lors du choix des cartes

enum Etat{ Main, Carte_Selected}

var ray
var draged = false
var timer = .0
var mouse_position = null
var card
var etat = Etat.Main
onready var main = get_node("/root/Main")
var hand = []

onready var scene = preload("res://Scenes/Carte.tscn")

#initialise la camera
func _ready():
	ray = $RayCast
	ray.enabled = false

#Gere le tactil
func _input(event):
	if event is InputEventScreenTouch:
		if !draged and !ray.enabled:
			ray.cast_to = project_ray_normal(event.position) * 120
			ray.enabled = true
		elif draged and !event.is_pressed():
			draged = false
			if card.drop() == 1:
				etat = Etat.Carte_Selected
				$"../MenuSelect".visible = true
				$"../Passer".visible = false
			else:
				card = null
	if event is InputEventScreenDrag and draged:
		mouse_position = translation + project_ray_normal(event.position)
	if event is InputEventScreenTouch and !event.is_pressed():
		mouse_position = null

#Gere le choix de la  carte, la validation et passer le tour
func _physics_process(delta):
	if hand.size() == 0:
		nuit()
		return
	if ray.is_colliding():
		var o = ray.get_collider()
		if o.is_in_group("Button") and o.is_in_group("Passer"):
			nuit()
	if etat == Etat.Main:
		drag(delta)
	elif etat == Etat.Carte_Selected:
		if ray.is_colliding():
			var o = ray.get_collider()
			if o.is_in_group("Button") and o.is_in_group("Oui"):
				if card.cart is PNJCard and main.food - card.cart.cost >= 0:
					main.population += card.cart.nbr
					main.food -= card.cart.cost
					hand.remove(hand.find(card))
					card.queue_free()
					reset()
				elif card.cart is BatCard and main.buildRessource - card.cart.cost >= 0 and main.population - card.cart.worker >= 0:
					$"..".visible = false
					var b = card.cart.getBuild()
					b.setCart(card.cart)
					hand.remove(hand.find(card))
					card.queue_free()
					reset()
					$"../../Camp/CameraBat".wakeup(b)
					stop()
				else:
					reset()
			elif o.is_in_group("Carte"):
				card.reset(o != card)
				card = null
				etat = Etat.Main
				$"../MenuSelect".visible = false
				$"../Passer".visible = true
				drag(delta)
			else:
				reset()
		elif ray.enabled:
			reset()

#le drag and drop d'une carte
func drag(delta):
	if ray.is_colliding() and ray.get_collider().is_in_group("Carte"):
		card = ray.get_collider()
		card.drag()
		ray.enabled = false
		draged = true
		timer = .0
	else:
		ray.enabled = false
	if draged and timer > 0.1 and mouse_position != null:
		var p = mouse_position * translation.distance_to(card.translation)
		card.translation = Vector3(p.x, p.y, card.translation.z)
	elif draged:
		timer += delta

#reinitilize la camera et la carte
func reset():
	card.reset(true)
	card = null
	etat = Etat.Main
	$"../MenuSelect".visible = false
	$"../Passer".visible = true
	ray.enabled = false
	draged = false

#Fonction qui s'occupe de preparer la camera pour le choix de carte
func wakeup():
	make_current()
	$"..".visible = true
	start()

#arrete la physique, les input et la vue
func stop():
	set_physics_process(false)
	set_process_input(false)
	$"..".visible = false

#demare la physique et les input
func start():
	set_physics_process(true)
	set_process_input(true)

#demare la nuit
func nuit():
	stop()
#	$"../../DirectionalLight".light_energy = 0.01
	$"../../WorldEnvironment".environment = preload("res://night_environment.tres")
	$"../../Camp/CameraNuit".wakeup()

#demarre le jour
func jour():
	main.j += 1
	for b in main.building:
		b.repair()
		b.prod()	
	while hand.size() < 3:
		var c = scene.instance()
		hand.append(c)
		c.setCard(main.deck[0], .0, -1.25)
		main.deck.remove(0)
		$"../".add_child(c)
	var x = -0.6
	for c in hand:
		c.translation.x = x
		c.pos_ini.x = x
		x+= 0.6
#	$"../../DirectionalLight".light_energy = 1.0
	$"../../WorldEnvironment".environment = preload("res://default_env.tres")
	wakeup()
