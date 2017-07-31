extends Node2D

export (float) var gutsNeeded = 20.0 setget _on_gutsNeeded_changed

onready var sprite = get_node("Sprite")
onready var sfx = get_node("SFX")
var gutsContained = 0.0
var fillPercent = 0.0
var led = 0

func _on_gutsNeeded_changed(val):
	gutsNeeded = val


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player" and led < 6:
		var gutCount = main.dropOffGuts()
		if gutCount > 0:
			sfx.play("GutsDropOff")
			gutsContained += gutCount
		updateLeds()
		if led > 5:
			sfx.play("ZGEFull")
	pass # replace with function body

func updateLeds():
	fillPercent = gutsContained / gutsNeeded
	if fillPercent > 100.0:
		fillPercent = 100.0
	led = round((fillPercent / 20.0)*100)
	print(led)
	sprite.set_frame(led)
	