extends Node2D
onready var btn = get_node("TextureButton")
onready var streamPlayer = get_node("StreamPlayer")

func _ready():
	main.playerHealth = 100.0
	btn.grab_focus()
	streamPlayer.play(0.0)
	main.backpack = 0
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene(main.getNextLevel())
	main.levelTimer.start()
	pass # replace with function body
