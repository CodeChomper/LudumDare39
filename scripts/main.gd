extends Node
var GRAVITY = 500

func _ready():
	pass

func gravity(vel,delta):
	vel.y += GRAVITY * delta
	return vel

func flip(node, left):
	var s = node.get_scale()
	if left: s.x *= -1
	else: s.x *= 1
	node.set_scale(s)