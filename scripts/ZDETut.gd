extends Area2D
onready var tutLabel = get_node("TutLabel")

func _ready():
	pass


func _on_ZGETut_body_enter( body ):
	if body.get_name() == "Player":
		tutLabel.set_hidden(false)
	pass # replace with function body


func _on_ZGETut_body_exit( body ):
	if body.get_name() == "Player":
		tutLabel.set_hidden(true)
	pass # replace with function body
