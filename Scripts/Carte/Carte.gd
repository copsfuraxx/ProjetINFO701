extends KinematicBody
#Script qui gere la carte physique

var cart:Card
var mouse_position
var pos_ini:Vector3

#fonction pour initialiser la carte
func setCard(_cart:Card, x:float, y:float):
	cart = _cart
	translation.x = x
	translation.y = y
	pos_ini = translation
	$Label3D.text = cart.cardName
	if cart.img != "null":
		$Sprite3D2.texture = load("res://Assets/Carte/" + cart.img)

#fonction qui change le visuel de la carte quand elle est drag
func drag():
	$Sprite3D.render_priority += 2
	$Label3D.render_priority += 2
	$Label3D.outline_render_priority += 2
	$Sprite3D2.render_priority += 2
	$Label3D2.render_priority += 2
	$Label3D2.outline_render_priority += 2
	translation.z += 0.1

#fonction qui change le visuel de la carte quand elle est drop
func drop():
	if translation.y > pos_ini.y + .5:
		scale = Vector3(1,1,1)
		translation = Vector3(-0.25,.5,0)
		return 1
	else:
		reset(true)
		return 2

#fonction qui remet la carte dans son etat d'origine
func reset(position:bool):
	scale = Vector3(.5,.5,.5)
	$Sprite3D.render_priority -= 2
	$Label3D.render_priority -= 2
	$Label3D.outline_render_priority -= 2
	$Sprite3D2.render_priority -= 2
	$Label3D2.render_priority -= 2
	$Label3D2.outline_render_priority -= 2
	if position:
		translation = pos_ini
