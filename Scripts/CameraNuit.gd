extends Camera

var zombie = preload("res://Scenes/Zombie.tscn")
onready var main = get_node("/root/Main")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	stop()

func wakeup():
	make_current()
	for i in range(0, main.j):
		var z = zombie.instance()
		var r = rng.randi_range(1,4)
		z.translation = get_node("../Spawn" + str(r)).translation
		$"..".add_child(z)
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)
