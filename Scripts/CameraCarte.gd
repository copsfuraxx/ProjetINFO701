extends Camera

enum Etat{ Main, Carte_Selected}

var ray
var draged = false
var timer = .0
var mouse_position = null
var card
var etat = Etat.Main
var main
var nbrCard = 3

onready var scene = preload("res://Scenes/Carte.tscn")

func _ready():
	ray = $RayCast
	ray.enabled = false
	main = get_node("/root/Main")

func _input(event):
	if event is InputEventScreenTouch:
		if !draged and !ray.enabled:
			ray.cast_to = project_ray_normal(event.position) * 10
			ray.enabled = true
		elif draged and !event.is_pressed():
			draged = false
			if card.drop() == 1:
				etat = Etat.Carte_Selected
				$"../MenuSelect".visible = true
			else:
				card = null
	if event is InputEventScreenDrag and draged:
		mouse_position = translation + project_ray_normal(event.position)
	if event is InputEventScreenTouch and !event.is_pressed():
		mouse_position = null

func _physics_process(delta):
	if etat == Etat.Main:
		drag(delta)
	elif etat == Etat.Carte_Selected:
		if ray.is_colliding():
			var o = ray.get_collider()
			if o.is_in_group("Button") and o.is_in_group("Oui"):
				if card.cart is PNJCard and main.food - card.cart.cost >= 0:
					main.population += card.cart.nbr
					main.food -= card.cart.cost
					card.queue_free()
					reset()
					nbrCard -= 1
#					draw()

				elif card.cart is BatCard and main.buildRessource - card.cart.cost >= 0 and main.population - card.cart.worker >= 0:
					$"..".visible = false
					var b = load("res://Scenes/Maison.tscn").instance()
					b.cart = card.cart
					card.queue_free()
					reset()
					nbrCard -= 1
					$"../../Camp/Camera".wakeup(b)
					stop()
				else:
					reset()
			elif o.is_in_group("Carte"):
				card.reset(o != card)
				card = null
				etat = Etat.Main
				$"../MenuSelect".visible = false
				drag(delta)
			else:
				reset()
		elif ray.enabled:
			reset()
	if nbrCard == 0:
		nbrCard = -1
		nuit()

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

func reset():
	card.reset()
	card = null
	etat = Etat.Main
	$"../MenuSelect".visible = false
	ray.enabled = false
	draged = false

func wakeup():
	make_current()
	$"..".visible = true
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)

func draw():
	var c = scene.instance()
	c.setCard(get_node("/root/Main").deck[0], card.pos_ini.x, -1.25)
	get_node("/root/Main").deck.remove(0)
	$"../".add_child(c)

func nuit():
	$"../../DirectionalLight".light_energy = 0.01
#	$"../../DirectionalLight".rotation_degrees.x += 180
#	$"../../DirectionalLight".light_color = Color("4e49f5")
	$"../../WorldEnvironment".environment = load("res://night_environment.tres")
