extends Node
var GRAVITY = 500
var backpack = 0
var MAX_BACKPACK = 2

func _ready():
	randomize()
	pass

func pick_up_guts():
	if backpack < MAX_BACKPACK:
		backpack += 1
		return true
	else:
		return false

func gravity(vel,delta):
	vel.y += GRAVITY * delta
	return vel

func flip(node, left):
	var s = node.get_scale()
	if left: s.x *= -1
	else: s.x *= 1
	node.set_scale(s)