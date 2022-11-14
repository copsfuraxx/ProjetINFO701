extends Camera

enum Etat{}

var ray
var mouse_position = null
var mouse_position_past = null
var click_position
var etat
var build
var case
var draged = true
var main

func _ready():
# Create the RayCast
	ray = $RayCast
	main = get_node("/root/Main")
	stop()

func _input(event):
	if event is InputEventScreenDrag:
		if event.relative.length() > 1:
			translate(Vector3(-event.relative.x / 300, event.relative.y / 300, .0))
			draged = true
	elif event is InputEventScreenTouch and !event.is_pressed():
		if draged:
			draged = false
		else:
			ray.cast_to = project_ray_normal(event.position) * 10
			ray.enabled = true

func _physics_process(_delta):
	if ray.is_colliding():
		ray.enabled = false
		var obj = ray.get_collider()
		if obj.is_in_group("Case"):
			build.translation = obj.translation
			case = obj
		elif obj.is_in_group("Oui"):
			main.buildRessource -= build.cart.cost
			main.population -= build.cart.worker
			case.queue_free()
			case = null
			build = null
			$MenuSelect.visible = false
			$"../../ChoixCarte/Camera".wakeup()
			stop()

func wakeup(b):
	build = b
	make_current()
	case = $"../Node".get_children()[0]
	build.translation.x = case.translation.x
	build.translation.z = case.translation.z
	$"../".add_child(build)
	#etat = Etat.Awake
	$MenuSelect.visible = true
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)
