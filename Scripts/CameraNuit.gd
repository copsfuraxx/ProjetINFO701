extends Camera

const zombie = preload("res://Scenes/Zombie.tscn")

onready var main = get_node("/root/Main")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	stop()

func wakeup():
	for b in main.building:
		b.start()
	for _i in range(main.j):
		var z = zombie.instance()
		main.zombies.append(z)
		var r = rng.randi_range(1,4)
		z.translation = get_node("../Spawn" + str(r)).translation
		$"..".add_child(z)
	make_current()
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)

func batDestroy():
	var loose = true
	for b in main.building:
		print(b.vie)
		if b.vie > 0:
			loose = false
	if loose:
		get_tree().change_scene("res://Scenes/GUI/MainMenu.tscn")

func zombieDead():
	if main.zombies.size() == 0:
		$"../../ChoixCarte/Camera".jour()
