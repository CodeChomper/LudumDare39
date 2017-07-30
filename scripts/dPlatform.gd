tool
extends TextureFrame

var sb
var cs
var shape
var midpoint

func _ready():
	if(get_tree().is_editor_hint()):
		set_process(true)
	sb = get_node("StaticBody2D")
	cs = get_node("StaticBody2D/CollisionShape2D")
	shape = RectangleShape2D.new()
	col_resize()
	pass

	
func _process(delta):
	col_resize()

func col_resize():
	if(get_size() / 2 != midpoint):
		print("resize")
		midpoint = get_size() / 2
		cs.set_shape(shape)
		cs.set_pos(midpoint)
		shape.set_extents(midpoint)