extends StaticBody2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		main.dropOffGuts()
	pass # replace with function body
