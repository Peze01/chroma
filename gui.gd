extends Control

@onready var swatch_scene = preload("res://Swatch.tscn")
@onready var palette_grid = $Palette/PaletteGrid

const COLOURS_TO_MIX = 2
var grid_array := []
var colour_depth = 3
var colour_array = []
var correct_swatches = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = 0.0
	var g = 0.0
	var b = 0.0
	var current_colour = [-1,-1,-1]
	while colour_array.size() < 9:
		if colour_depth <=2:
			colour_depth = 3
		r = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		g = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		b = (1.0 / (colour_depth-1)) * (randi_range(0,colour_depth-1))
		current_colour = [r,g,b]
		if current_colour not in colour_array:
			colour_array.push_back(current_colour)
		current_colour = [-1,-1,-1]

	for i in range(9):
		create_palette()
	create_result()
	
		#print(grid_array[i].get_background(), colour_array[i], "\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_palette():
	var new_swatch = swatch_scene.instantiate()
	new_swatch.swatch_ID = grid_array.size()
	new_swatch.set_background(colour_array[new_swatch.swatch_ID])
	palette_grid.add_child(new_swatch)
	grid_array.push_back(new_swatch)


func create_result():
	var current_rand = -1
	while correct_swatches.size() < 2:
		current_rand = randi_range(0,8)
		if current_rand not in correct_swatches:
			correct_swatches.push_back(current_rand)
	
	var new_r = (grid_array[correct_swatches[0]].get_background().r
	+ grid_array[correct_swatches[1]].get_background().r) / 2
	var new_g = (grid_array[correct_swatches[0]].get_background().g
	+ grid_array[correct_swatches[1]].get_background().g) / 2
	var new_b = (grid_array[correct_swatches[0]].get_background().b
	+ grid_array[correct_swatches[1]].get_background().b) / 2
	
	print(correct_swatches)
	print(colour_array[correct_swatches[0]], colour_array[correct_swatches[1]])
	$Result.color = Color(new_r, new_g, new_b)
