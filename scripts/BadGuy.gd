extends KinematicBody2D
var health = 100
var state = 'idle'
signal dead

func _ready():
	health = 100
	pass

func takeDamage(damage):
	self.health -= damage
	print('ouch my health is: ' + str(self.health))
	if health <= 0:
		state = 'dead'
		emit_signal("dead")