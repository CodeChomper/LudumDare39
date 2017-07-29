extends KinematicBody2D

export var dir = "right"
var POWER = 15
var DAMAGE = 50
var vel = Vector2(0,0)


func _ready():
	set_process(true)
	if dir == "right":
		vel.x = POWER
	else:
		vel.x = -POWER

func _process(delta):
	if self.is_colliding():
		var node = self.get_collider()
		if(node and node.is_in_group("badGuys")):
			node.takeDamage(DAMAGE)
		queue_free()
	move(vel)

func _on_RemoveTimer_timeout():
	print("remove")
	queue_free()
