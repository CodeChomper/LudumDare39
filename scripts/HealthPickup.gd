extends Sprite

export (float) var healthPoints = 20 setget _on_health_points_changed_ui

func _on_health_points_changed_ui(val):
	healthPoints = val

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and main.playerHealth <= (100.0 - healthPoints):
		main.increasePlayerHealth(healthPoints)
		print(str(main.playerHealth))
		queue_free()