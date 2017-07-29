extends KinematicBody2D

onready var floorRayL = get_node("FloorRayL")
onready var floorRayR = get_node("FloorRayR")
onready var idleTimer = get_node("IdleTimer")
onready var walkForwardRay = get_node("WalkForwardRay")

var DRAG = 0.92

var walkSpeed = 15.0
var state = "idle"
var onGround = false
var facingRight = true
var vel = Vector2(0,0)

func _ready():
	set_fixed_process(true)
	idleTimer.start()
	floorRayL.add_exception(self)
	floorRayR.add_exception(self)
	walkForwardRay.add_exception(self)
	
	pass

func _fixed_process(delta):
	vel = main.gravity(vel,delta)
	vel.x *= DRAG
	onGround = floorRayL.is_colliding() or floorRayR.is_colliding()
	
	#turn around of no floor infront of you
	if not walkForwardRay.is_colliding():
		_turn_around()
	
	#handle movement via states
	if state == "run":
		if facingRight:
			vel.x += walkSpeed
		else:
			vel.x -= walkSpeed

	var motion = vel * delta
	move(motion)
	
	if self.is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)


func _on_idle_timer_time_out():
	state = "run"

func _on_FrontCollision_body_enter( b ):
	if b.is_in_group("level"):
		_turn_around()

func _turn_around():
	main.flip(self,facingRight)
	facingRight = !facingRight
	vel.x = 0
	state = "idle"
	idleTimer.start()
