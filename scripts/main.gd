extends Node
var levels = ["res://scenes/Menu.tscn","res://scenes/Level1.tscn"]
var curLevel = 0
var GRAVITY = 500
var backpack = 0
var MAX_BACKPACK = 6
var power = 100.0

var levelTimer

func _ready():
	randomize()
	levelTimer = Timer.new()
	levelTimer.set_wait_time(0.5)
	levelTimer.connect("timeout",self,"_on_level_tick")
	add_child(levelTimer)
	pass

func getNextLevel():
	curLevel += 1
	if curLevel >= levels.size():
		curLevel = 0
	return levels[curLevel]

func getLightPower():
	var lightPower = 0.0
	if(main.power > 11):
		lightPower = 100 * (0.5/main.power) + 1
	else:
		lightPower = 4.0
	return lightPower

func _on_level_tick():
	#print('power is : ' + str(power))
	power -= 1

func dropOffGuts():
	var gutsDropedOff = 0
	for i in range(0,backpack):
		gutsDropedOff += 1
		power += 10
		if power > 100:
			power = 100
	backpack = 0
	return gutsDropedOff

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