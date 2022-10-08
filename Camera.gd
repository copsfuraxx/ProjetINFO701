extends Camera

enum Etat{ Main, Carte_Selected}

var ray
var triger = false
var timer = .0
var mouse_position
var mouse_origin
var card
var etat

func _ready():
# Create the RayCast
	ray = $RayCast
	etat = Etat.Main

func _input(event):
	if Input.is_action_just_pressed("click") :
		var to = project_ray_normal(event.position) * 10
		ray.cast_to = to
		ray.enabled = true
	elif etat == Etat.Main and Input.is_action_just_released("click") and triger:
		triger = false
		if card.drop() == 1:
			etat = Etat.Carte_Selected
			$"../MenuSelect".visible = true
		else:
			card = null
	if Input.is_action_pressed("click"):
		mouse_origin = project_ray_origin(event.position)
		mouse_position = mouse_origin +  project_ray_normal(event.position)

func _physics_process(delta):
	if etat == Etat.Main:
		drag(delta)
	elif etat == Etat.Carte_Selected:
		if ray.is_colliding():
			var o = ray.get_collider()
			if o.is_in_group("Button"):
				if o.is_in_group("Oui"):
					print_debug("oui")
				reset()
			elif o.is_in_group("Carte"):
				card.reset()
				card = null
				etat = Etat.Main
				$"../MenuSelect".visible = false
				drag(delta)
		elif ray.enabled:
			reset()

func drag(delta):
	if ray.is_colliding() and ray.get_collider().is_in_group("Carte"):
		card = ray.get_collider()
		card.drag()
		ray.enabled = false
		triger = true
		timer = 0
	if triger and timer > 0.1:
		var p = mouse_position * mouse_origin.distance_to(card.translation)
		card.translation = Vector3(p.x, p.y, card.translation.z)
	elif triger:
		timer += delta

func reset():
	card.reset()
	card = null
	etat = Etat.Main
	$"../MenuSelect".visible = false
	ray.enabled = false
