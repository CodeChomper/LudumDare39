extends KinematicBody2D

onready var floorRayL = get_node("FloorRayL")
onready var floorRayR = get_node("FloorRayR")
onready var bulletSpawn = get_node("BulletSpawn")
onready var shotCoolDown = get_node("ShotCoolDown")
onready var bull = preload('res://scenes/Bullet.tscn')
onready var anim = get_node("AnimatedSprite")
onready var muzzelFlash = get_node("BulletSpawn/MuzzelFlash")
onready var light = get_node("Camera2D/Light2D")
onready var muzzelFlashLight = get_node("BulletSpawn/MuzzelFlash/MuzzelFlashLight")

var DRAG = 0.92
var GUN_KICK = 200

var walkSpeed = 20.0
var jumpSpeed = 175
var vel = Vector2(0,0)
var onGround = false
var state = "idle"  # idle run dead
var up = false
var down = false
var left = false
var right = false
var shoot = false
var canShoot = true
var facingRight = true

func _ready():
	set_fixed_process(true)
	floorRayL.add_exception(self)
	floorRayR.add_exception(self)
	pass

func _fixed_process(delta):
	muzzelFlashLight.set_energy(main.getLightPower() * 10)
	light.set_energy(main.getLightPower())
	updateAnimations()
	up = Input.is_action_pressed("player_up")
	down = Input.is_action_pressed("player_down")
	left = Input.is_action_pressed("player_left")
	right = Input.is_action_pressed("player_right")
	shoot = Input.is_action_pressed("player_shoot")
	
	onGround = (floorRayL.is_colliding() or floorRayR.is_colliding()) 
	if not onGround and vel.y <= 0:
		state = "jumpUp"
	if not onGround and vel.y > 0:
		state = "jumpDown"
	
	if shoot and canShoot and onGround:
		shoot()
	
	if onGround and abs(vel.x) < 3:
		state = 'idle'
	
	# handle movement
	movement(delta)


func updateAnimations():
	anim.play(state)

func movement(delta):
	vel = main.gravity(vel,delta)
	vel.x *= DRAG
	
	if left and not right and state != "shoot":
		main.flip(self,true)
		facingRight = false
		vel.x -= walkSpeed
		if onGround:
			state = "run"
	
	if right and not left and state != "shoot":
		main.flip(self,false)
		facingRight = true
		vel.x += walkSpeed
		if onGround:
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

func _on_ShotCoolDown_timeout():
	canShoot = true
	if not Input.is_action_pressed("player_shoot"):
		state = 'idle'

func shoot():
	muzzelFlashLight.set_hidden(false)
	muzzelFlash.set_frame(0)
	muzzelFlash.play("shoot")
	state = "shoot"
	var b = bull.instance()
	if facingRight:
		b.dir = "right"
		vel.x -= GUN_KICK
	else:
		b.dir = "left"
		vel.x += GUN_KICK
	get_parent().add_child(b)
	b.set_global_pos(bulletSpawn.get_global_pos())
	canShoot = false
	shotCoolDown.start()

func _on_MuzzelFlash_finished():
	muzzelFlash.play("default")
	muzzelFlashLight.set_hidden(true)
	
	pass # replace with function body
