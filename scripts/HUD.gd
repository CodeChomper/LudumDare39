extends Node2D

onready var panelFG = get_node("CanvasLayer/PanelFG")
onready var heart1 = get_node("CanvasLayer/Heart1")
onready var heart2 = get_node("CanvasLayer/Heart2")
onready var heart3 = get_node("CanvasLayer/Heart3")
onready var heart4 = get_node("CanvasLayer/Heart4")
onready var heart5 = get_node("CanvasLayer/Heart5")
onready var canvas = get_node("CanvasLayer")

func _ready():
	set_process(true)
	canvas.set_offset(Vector2(0,0))
	pass

func _process(delta):
	panelFG.set_size(Vector2(main.power*5,20))
	var heartsOn = round(main.playerHealth / 20.0)
	
	if heartsOn == 5:
		heart1.play("full")
		heart2.play("full")
		heart3.play("full")
		heart4.play("full")
		heart5.play("full")
	elif heartsOn == 4:
		heart1.play("full")
		heart2.play("full")
		heart3.play("full")
		heart4.play("full")
		heart5.play("empty")
	elif heartsOn == 3:
		heart1.play("full")
		heart2.play("full")
		heart3.play("full")
		heart4.play("empty")
		heart5.play("empty")
	elif heartsOn == 2:
		heart1.play("full")
		heart2.play("full")
		heart3.play("empty")
		heart4.play("empty")
		heart5.play("empty")
	elif heartsOn == 1:
		heart1.play("full")
		heart2.play("empty")
		heart3.play("empty")
		heart4.play("empty")
		heart5.play("empty")
	else:
		heart1.play("empty")
		heart2.play("empty")
		heart3.play("empty")
		heart4.play("empty")
		heart5.play("empty")