extends Camera

enum Etat{}

var ray
var mouse_position = null
var mouse_position_past = null
var click_position
var etat
var build
var draged = true

func _ready():
# Create the RayCast
	ray = $RayCast
	stop()

func _input(event):
	if event is InputEventScreenDrag:
		translate(Vector3(-event.relative.x / 100, event.relative.y / 100, .0))
		draged = true
	elif event is InputEventScreenTouch and !event.is_pressed():
		if draged:
			draged = false
		else:
			ray.cast_to = project_ray_normal(event.position) * 10
			ray.enabled = true

func _physics_process(_delta):
	if ray.is_colliding() and ray.get_collider().is_in_group("Case"):
		var case = ray.get_collider()
		ray.enabled = false
		build.translation = case.translation

func wakeup(b):
	build = b
	make_current()
	build.translation.x = .5
	build.translation.z = .5
	$"../".add_child(build)
	#etat = Etat.Awake
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)
