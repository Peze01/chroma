extends Control

@onready var slot_scene = preload("res://slot.tscn")
@onready var palette_grid = $Grid/PaletteGrid

const COLOURS_TO_MIX = 2
var grid_array := []
var colour_depth = 3
var colour_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = 0.0
	var g = 0.0
	var b = 0.0
	var current_colour = [-1,-1,-1]
	while colour_array.size() < 9:
		r = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		g = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		b = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		current_colour = [r,g,b]
		if current_colour not in colour_array:
			colour_array.push_back(current_colour)
		current_colour = [-1,-1,-1]

	for i in range(9):
		create_slot()
	for i in range(9):
		grid_array[i].set_background(colour_array[i])
		#print(grid_array[i].get_background(), colour_array[i], "\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	palette_grid.add_child(new_slot)
	grid_array.push_back(new_slot)
	
	
