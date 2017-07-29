extends Node2D

onready var zombie = preload("res://scenes/Zombie.tscn")
onready var spawnTimer = get_node("SpawnTimer")

func _ready():
	self.set_hidden(true)
	spawnTimer.set_wait_time(rand_range(8,20))
	spawnTimer.start()
	pass


func _on_SpawnTimer_timeout():
	#count how many badguys
	if get_tree().get_nodes_in_group("badGuys").size() < 4:
		print('adding zombie now')
		spawnTimer.set_wait_time(rand_range(8,20))
		spawnTimer.start()
		var z = zombie.instance()
		z.set_global_pos(get_global_pos())
		get_parent().add_child(z)
