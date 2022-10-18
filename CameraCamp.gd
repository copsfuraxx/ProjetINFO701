extends Camera

enum Etat{Sleep, Awake}

var ray
var mouse_position = null
var mouse_position_past = null
var click_position
var click = false
var etat = Etat.Sleep

func _ready():
# Create the RayCast
	ray = $RayCast

func _input(event):
	if(etat == Etat.Sleep):
		return
	if Input.is_action_just_pressed("click") :
		var to = project_ray_normal(event.position) * 10
		ray.cast_to = to
		ray.enabled = true
	if Input.is_action_pressed("click"):
		if mouse_position != null:
			mouse_position_past = mouse_position
		mouse_position = event.position
		click_position = translation + project_ray_normal(event.position)
		click = true
	if Input.is_action_just_released("click"):
		click = false
		mouse_position = null
		mouse_position_past = null

func _physics_process(_delta):
	if(etat == Etat.Sleep):
		return
	if click and mouse_position_past != null:
		var x = translation.x - (mouse_position.x - mouse_position_past.x) / 120
		var z = translation.z - (mouse_position.y - mouse_position_past.y) / 120
		translation = Vector3(x, translation.y, z)
	click = false

func wakeup(b):
	make_current()
	b.translation.x = .5
	b.translation.z = .5
	$"../".add_child(b)
	etat = Etat.Awake
