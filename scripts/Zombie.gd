extends 'res://scripts/BadGuy.gd'

onready var floorRayL = get_node("FloorRayL")
onready var floorRayR = get_node("FloorRayR")
onready var idleTimer = get_node("IdleTimer")
onready var walkForwardRay = get_node("WalkForwardRay")
onready var attackCooldown = get_node("AttackCooldown")
onready var guts = preload("res://scenes/ZombieGuts.tscn")

var DRAG = 0.92
var walkSpeed = 15.0
var onGround = false
var facingRight = true
var vel = Vector2(0,0)

func _ready():
	set_fixed_process(true)
	idleTimer.start()
	floorRayL.add_exception(self)
	floorRayR.add_exception(self)
	walkForwardRay.add_exception(self)
	connect("dead",self,"_on_dead")
	
	pass

func _fixed_process(delta):
	if state == 'dead':
		return

	vel = main.gravity(vel,delta)
	vel.x *= DRAG
	onGround = floorRayL.is_colliding() or floorRayR.is_colliding()
	
	#turn around of no floor infront of you
	if not state == 'attack' and not walkForwardRay.is_colliding():
		_turn_around()
	
	#handle movement via states
	if state == "run":
		if facingRight:
			vel.x += walkSpeed
		else:
			vel.x -= walkSpeed
	
	#attack mode
	if state == 'attack':
		if facingRight:
			vel.x += walkSpeed * 1.5
		else:
			vel.x -= walkSpeed * 1.5

	var motion = vel * delta
	move(motion)
	
	if self.is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)


func _on_idle_timer_time_out():
	if state != 'dead':
		state = "run"

func _on_FrontCollision_body_enter( b ):
	if b.is_in_group("level") or (b.is_in_group("badGuys") and b != self and state != 'dead'):
		_turn_around()

func _turn_around():
	main.flip(self,facingRight)
	facingRight = !facingRight
	vel.x = 0
	state = "idle"
	idleTimer.start()


func _on_VisionCone_body_enter( body ):
	# Lets see if zombie fights are cool if not check for player
	if body.get_name() == 'Player' and state != 'dead':
		state = 'attack'


func _on_VisionCone_body_exit( body ):
	if body.get_name() == 'Player' and state != 'dead':
		attackCooldown.start()

func _on_AttackCooldown_timeout():
	if state != 'dead':
		state = "idle"
		idleTimer.start()
	
func _on_dead():
	clear_shapes()
	for i in range(0,rand_range(2,6)):
		var g = guts.instance()
		g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
		g.set_global_pos(get_global_pos())
		self.get_parent().add_child(g)
	
	print("i am dead")