extends KinematicBody

onready var animation = $AnimationTree.get("parameters/playback")
onready var main = get_node("/root/Main")
var walk = false
var cible = null
var speed = 1
var spawn_time = 2.867

func _physics_process(delta):
	if walk:
		if cible == null:
			getCible()
		var direction = translation.direction_to(cible.translation) * speed
		move_and_slide(direction)
	else:
		spawn_time -= delta
		if spawn_time <= 0:
			walk = true
			animation.travel("WALK")

func getCible():
	cible = main.building[0]
	for b in main.building:
		var d1 = translation.distance_to(b.translation)
		var d2 = translation.distance_to(cible.translation)
		if d1 < d2:
			cible = b
	look_at(cible.translation, Vector3.UP)
