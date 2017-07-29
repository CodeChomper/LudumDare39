extends RigidBody2D

onready var aera2D = get_node("Area2D")

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		queue_free()
	pass # replace with function body
