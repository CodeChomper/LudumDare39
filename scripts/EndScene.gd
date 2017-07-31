extends Node2D



func _ready():
	main.curLevel = main.levels.size()
	main.levelTimer.stop()
	pass

func _on_ResetTimer_timeout():
	get_tree().change_scene(main.getNextLevel())
	pass # replace with function body
