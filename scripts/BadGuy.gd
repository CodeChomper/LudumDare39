extends KinematicBody2D
var health = 100
var state = 'idle'

func _ready():
	health = 100
	pass

func takeDamage(damage):
	self.health -= damage
	print('ouch my health is: ' + str(self.health))
	if health <= 0:
		state = 'dead'