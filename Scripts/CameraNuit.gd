extends Camera

const zombie = preload("res://Scenes/Zombie.tscn")

var main 
var rng = RandomNumberGenerator.new()

func _ready():
	main = get_node("/root/Main")
	rng.randomize()
	stop()

func wakeup():
	for b in main.building:
		b.start()
	for _i in range(0, main.j):
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
