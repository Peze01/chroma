extends ColorRect

signal swatch_selected(swatch)
var swatch_ID := -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_background(c):
		color = Color(c[0],c[1],c[2])
func get_background():
	return color

func _on_swatch_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		emit_signal("swatch_selected", self)
		
