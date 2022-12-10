extends KinematicBody

enum Etat {spawn = 1, walk = 2, attack = 3, dead = 4}

signal hit(dammage)

onready var animation = $AnimationTree.get("parameters/playback")
onready var main = get_node("/root/Main")
var etat = Etat.spawn
var cible = null
const speed = 1
const spawn_time = 2.867
const attack_speed = 2.067
var timer = spawn_time

func _physics_process(delta):
	match etat:
		Etat.spawn:
			if timer - delta <= .0:
				etat = Etat.walk
				animation.travel("WALK")
			else:
				timer -= delta
		Etat.walk:
			if cible == null || cible.vie == 0:
				getCible()
			var direction = translation.direction_to(cible.translation) * speed
			direction = move_and_slide(direction)
			var c = null
			if get_last_slide_collision() != null:
				c = get_last_slide_collision().collider
			if (c != null && c.is_in_group("Build")):
				connect("hit", c, "hit", [1])
				timer = attack_speed
				etat = Etat.attack
				animation.travel("ATK")
		Etat.attack:
			if timer - delta <= .0:
				emit_signal("hit")
				timer = attack_speed
			else:
				if cible.vie == 0:
					cible = null
					etat = Etat.walk
					animation.travel("WALK")
				else :
					timer -= delta

func getCible():
	for b in main.building:
		if b.vie > 0:
			if cible == null:
				cible = b
			else:
				var d1 = translation.distance_to(b.translation)
				var d2 = translation.distance_to(cible.translation)
				if d1 < d2:
					cible = b
	look_at(cible.translation, Vector3.UP)
