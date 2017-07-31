extends Sprite

export (float) var healthPoints = 20 setget _on_health_points_changed_ui
onready var sfx = get_node("SFX")
onready var soundTimer = get_node("SoundTimer")
onready var area2D = get_node("Area2D")

func _on_health_points_changed_ui(val):
	healthPoints = val

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and main.playerHealth <= (100.0 - healthPoints):
		main.increasePlayerHealth(healthPoints)
		print(str(main.playerHealth))
		sfx.play("HealthPickup")
		area2D.clear_shapes()
		self.set_hidden(true)
		soundTimer.start()

func _on_SoundTimer_timeout():
	queue_free()
	pass # replace with function body
