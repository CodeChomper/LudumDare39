extends Sprite
onready var levelSwitchTimer = get_node("LevelSwitchTimer")
onready var anim = get_node("AnimationPlayer")
export(float) var power = 100.0 setget _on_power_changed_ui
func _ready():

	pass

func _on_power_changed_ui(val):
	power = val
	main.power = power

func _on_Area2D_body_enter( body ):
	if body.get_name() == 'Player':
		if checkAllZGEs():
			levelSwitchTimer.start()
			power = main.power
			anim.play("fadeOut")
	pass # replace with function body

func checkAllZGEs():
	for zge in get_tree().get_nodes_in_group("ZGE"):
		print(str(zge.fillPercent))
		if zge.fillPercent < 1.0:
			return false
	return true

func _on_LevelSwitchTimer_timeout():
	get_tree().change_scene(main.getNextLevel())