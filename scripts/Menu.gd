extends Node2D

func _ready():
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene(main.getNextLevel())
	main.levelTimer.start()
	pass # replace with function body
