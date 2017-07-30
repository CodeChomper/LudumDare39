extends Sprite
onready var light = get_node("Light2D")
onready var flickerTimer = get_node("FlickerTimer")
onready var dir = true
export (bool) var flicker setget _on_flicker_change
var delta = 0
func _ready():
	randomize()
	delta = randf() - 0.2
	flickerTimer.set_wait_time(rand_range( 0.15, 0.5))
	if flicker:
		flickerTimer.set_autostart(true)
		flickerTimer.start()
	pass

func _on_flicker_change(val):
	flicker = val

func _on_FlickerTimer_timeout():
	#change the intesity of the light
	dir = !dir
	if dir:
		light.set_energy(1+delta)
	else:
		light.set_energy(1-delta)

	#set random range for timer
	flickerTimer.set_wait_time(rand_range( 0.15, 0.5))