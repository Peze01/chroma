extends TextureButton

signal normal_selected(button)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_normal_pressed():
	emit_signal("normal_selected", self)
