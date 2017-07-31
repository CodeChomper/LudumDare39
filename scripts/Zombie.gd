extends 'res://scripts/BadGuy.gd'

onready var floorRayL = get_node("FloorRayL")
onready var floorRayR = get_node("FloorRayR")
onready var idleTimer = get_node("IdleTimer")
onready var walkForwardRay = get_node("WalkForwardRay")
onready var attackCooldown = get_node("AttackCooldown")
onready var guts = preload("res://scenes/ZombieGuts.tscn")
onready var zgHead = preload("res://scenes/ZGHead.tscn")
onready var zgChest = preload("res://scenes/ZGChest.tscn")
onready var zgPelvus = preload("res://scenes/ZGPelvus.tscn")
onready var zgArm = preload("res://scenes/ZGArm.tscn")
onready var zgLeg = preload("res://scenes/ZGLeg.tscn")
onready var anim = get_node("AnimatedSprite")
onready var decayTimer = get_node("DecayTimer")
onready var eye1 = get_node("Light2D")
onready var eye2 = get_node("Light2D1")
onready var sfx = get_node("SFX")
onready var roamSFXTimer = get_node("RoamSoundTimer")

var DRAG = 0.92
var walkSpeed = 8.0
var onGround = false
export (bool) var facingRight = true setget _on_change_facingRight_ui
var vel = Vector2(0,0)

func _ready():
	set_fixed_process(true)
	idleTimer.start()
	floorRayL.add_exception(self)
	floorRayR.add_exception(self)
	walkForwardRay.add_exception(self)
	connect("dead",self,"_on_dead")

func _on_change_facingRight_ui(val):
	facingRight = val

func _fixed_process(delta):
	if get_pos().y > 10000:
		print('fell to my death')
		queue_free()
	anim.play(state)
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
			vel.x += walkSpeed * 1.8
		else:
			vel.x -= walkSpeed * 1.8

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
	if (b.is_in_group("level") or (b.is_in_group("badGuys")) and b != self and state != 'dead'):
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
	eye1.set_hidden(true)
	eye2.set_hidden(true)
	decayTimer.start()
	clear_shapes()
	for i in range(0,rand_range(2,6)):
		if i == 1:
			var g = zgHead.instance()
			g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
			g.set_global_pos(get_global_pos())
			self.get_parent().add_child(g)
		if i == 2:
			var g = zgChest.instance()
			g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
			g.set_global_pos(get_global_pos())
			self.get_parent().add_child(g)
		if i == 3:
			var g = zgPelvus.instance()
			g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
			g.set_global_pos(get_global_pos())
			self.get_parent().add_child(g)
		if i == 4:
			var g = zgLeg.instance()
			g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
			g.set_global_pos(get_global_pos())
			self.get_parent().add_child(g)
		if i == 5:
			var g = zgArm.instance()
			g.set_linear_velocity(Vector2(rand_range(-300,300),rand_range(-50,-300)))
			g.set_global_pos(get_global_pos())
			self.get_parent().add_child(g)
		
	
	print("i am dead")

func _on_DecayTimer_timeout():
	print("decay")
	queue_free()
	pass # replace with function body


func _on_RoamSoundTimer_timeout():
	if state == "run":
		sfx.play("ZombieRoam")
		roamSFXTimer.set_wait_time(rand_range(2,9))
		roamSFXTimer.start()
	
	pass # replace with function body
