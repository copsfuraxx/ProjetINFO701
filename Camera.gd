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
	ray = RayCast.new()
	ray.set_name("RayCast")
	add_child(ray)
	etat = Etat.Main

func _input(event):
	if etat == Etat.Main and Input.is_action_just_pressed("click") :
		var to = project_ray_normal(event.position) * 10
		
		ray.cast_to = to
		
		ray.enabled = true
		mouse_origin = project_ray_origin(event.position)
		mouse_position = mouse_origin + project_ray_normal(event.position)
	elif etat == Etat.Main and Input.is_action_pressed("click"):
		mouse_origin = project_ray_origin(event.position)
		mouse_position = mouse_origin +  project_ray_normal(event.position)
	elif etat == Etat.Main and Input.is_action_just_released("click") and triger:
		triger = false
		var i = card.drop()
		if i == 1:
			etat = Etat.Carte_Selected
		else:
			card = null
	elif etat == Etat.Carte_Selected:
		if Input.is_action_just_pressed("click"):
			var to = project_ray_normal(event.position) * 10
			ray.cast_to = to
			ray.enabled = true

func _physics_process(delta):
	if etat == Etat.Main:
		if ray.is_colliding() :
			card = ray.get_collider()
			card.drag()
			ray.enabled = false
			triger = true
			timer = 0
			
		if triger and timer > 0.1:
			var p = mouse_position * mouse_origin.distance_to(card.translation)
			card.translation = Vector3(p.x, p.y, card.translation.z)
		if triger:
			timer += delta
	elif etat == Etat.Carte_Selected:
		if ray.is_colliding() :
			var o = ray.get_collider()
			if o.is_in_group("Button"):
				print("oui")
			else:
				card.reset()
				card = null
				etat = Etat.Main
			ray.enabled = false
