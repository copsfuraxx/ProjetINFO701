extends Camera
#Script qui gère la camera lors du choix des cartes

const zombie = preload("res://Scenes/Zombie.tscn")

onready var main = get_node("/root/Main")
var rng = RandomNumberGenerator.new()

func _ready():
	stop()

#Gere le movement de la camera
func _input(event):
	if event is InputEventScreenDrag:
		translate(Vector3(-event.relative.x / 300, event.relative.y / 300, .0))

#Fonction qui s'occupe de preparer la camera pour la nuit
func wakeup():
	for b in main.building:
		b.start()
		rng.randomize()
	var r = rng.randi_range(1,4)
	var px = .0
	var py = -.5
	for i in range(main.j):
		var z = zombie.instance()
		main.zombies.append(z)
		z.translation = get_node("../Spawn" + str(r)).translation
		match r:
			1:
				z.translation.x += px
				z.translation.z += py
			2:
				z.translation.x -= px
				z.translation.z -= py
			3:
				z.translation.x += py
				z.translation.z += px
			4:
				z.translation.x -= py
				z.translation.z -= px
		py += .5
		if i % 3 == 2:
			px += .5
			py = -.5
		$"..".add_child(z)
	make_current()
	start()

func stop():
	set_physics_process(false)
	set_process_input(false)

func start():
	set_physics_process(true)
	set_process_input(true)

#Vérifie si le joueur a perdu
func batDestroy():
	var loose = true
	for b in main.building:
		if b.vie > 0:
			loose = false
	if loose:
		main.reset()
		var web = HTTPRequest.new()
		web.connect("request_completed", self, "request_completed")
		$"../".add_child(web)
		stop()
		web.request("http://" + main.ip + ":3000/INSERT_SCORE?nom=" + main.joueur + "&score=" + str(main.j))

#Vérifie si la nuit est terminé
func zombieDead():
	if main.zombies.size() == 0:
		$"../../ChoixCarte/Camera".jour()

func request_completed(_result, _response_code, _headers, _body):
	var _ignored = get_tree().change_scene("res://Scenes/GUI/MainMenu.tscn")
