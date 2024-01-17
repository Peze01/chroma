extends Control

@onready var slot_scene = preload("res://slot.tscn")
@onready var palette_grid = $Grid/PaletteGrid

var grid_array := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(8):
		create_slot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	palette_grid.add_child(new_slot)
	grid_array.push_back(new_slot)
