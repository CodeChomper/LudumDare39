extends Node2D

onready var panelFG = get_node("CanvasLayer/PanelFG")

func _ready():
	set_process(true)
	pass

func _process(delta):
	panelFG.set_size(Vector2(main.power*5,20))