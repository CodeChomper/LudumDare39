extends RigidBody2D

onready var aera2D = get_node("Area2D")
onready var cs = get_node("CollisionShape2D")
onready var decayTimer = get_node("DecayTimer")

func _ready():
	set_process(true)
	pass

func _process(delta):
	if abs(get_linear_velocity().x) < 1 and abs(get_linear_velocity().y) < 1:
		if not cs.is_trigger():
			decayTimer.start()
		cs.set_trigger(true)
		self.set_sleeping(true)
func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		var pickedUp = main.pick_up_guts()
		if pickedUp:
			queue_free()
	pass # replace with function body


func _on_DecayTimer_timeout():
	queue_free()
	pass # replace with function body
