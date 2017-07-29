extends KinematicBody2D

onready var floorRayL = get_node("FloorRayL")
onready var floorRayR = get_node("FloorRayR")

var DRAG = 0.92

var walkSpeed = 20.0
var jumpSpeed = 400
var vel = Vector2(0,0)
var onGround = false
var state = "idle"  # idle run dead
var up = false
var down = false
var left = false
var right = false

func _ready():
	set_fixed_process(true)
	floorRayL.add_exception(self)
	floorRayR.add_exception(self)
	pass

func _fixed_process(delta):
	up = Input.is_action_pressed("player_up")
	down = Input.is_action_pressed("player_down")
	left = Input.is_action_pressed("player_left")
	right = Input.is_action_pressed("player_right")
	
	onGround = floorRayL.is_colliding() or floorRayR.is_colliding()
	
	if onGround and abs(vel.x) < 3:
		state = 'idle'
	
	# handle movement
	movement(delta)
	
func movement(delta):
	vel = main.gravity(vel,delta)
	vel.x *= DRAG
	
	if left and not right:
		main.flip(self,true)
		vel.x -= walkSpeed
		state = "run"
	
	if right and not left:
		main.flip(self,false)
		vel.x += walkSpeed
		state = "run"
	
	if onGround and up:
		vel.y -= jumpSpeed
	
	var motion = vel * delta
	move(motion)
	
	if self.is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)