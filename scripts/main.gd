extends Node
var GRAVITY = 500
var backpack = 0
var MAX_BACKPACK = 2
var power = 100

var levelTimer

func _ready():
	randomize()
	levelTimer = Timer.new()
	levelTimer.set_wait_time(2)
	levelTimer.set_autostart(true)
	levelTimer.connect("timeout",self,"_on_level_tick")
	add_child(levelTimer)
	pass

func _on_level_tick():
	print('power is : ' + str(power))
	power -= 1

func dropOffGuts():
	for i in range(0,backpack):
		power += 10
		if power > 100:
			power = 100
	backpack = 0
	

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