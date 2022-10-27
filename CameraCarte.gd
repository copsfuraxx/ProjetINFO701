extends Camera

enum Etat{ Main, Carte_Selected}

var ray
var draged = false
var timer = .0
var mouse_position = Vector2.ZERO
var card
var etat = Etat.Main
var main

func _ready():
# Create the RayCast
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
					reset()
				else:
					$"..".visible = false
					var b = load("res://Maison.tscn").instance()
					b.cart = card.cart
					$"../../Camp/Camera".wakeup(b)
					stop()
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

func drag(delta):
	if ray.is_colliding() and ray.get_collider().is_in_group("Carte"):
		card = ray.get_collider()
		card.drag()
		ray.enabled = false
		draged = true
		timer = .0
	else:
		ray.enabled = false
	if draged and timer > 0.1:
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
	reset()
	$"..".visible = true
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)
