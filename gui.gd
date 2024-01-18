extends Control

@onready var swatch_scene = preload("res://Swatch.tscn")
@onready var palette_grid = $Palette/PaletteGrid
@onready var score_node = $Score
@onready var normal_button = $Normal
@onready var hard_button = $Hard
@onready var highscore_node = $HighScore

const COLOURS_TO_MIX = 2
var COLOUR_DEPTH = 3


var selected_difficulty := 0
var PALETTE_SIZE = 4
var SWATCH_SIZE = 176

var grid_array := []
var colour_array = []
var correct_swatches = [null, null]
var score = 0
var highscore = 0
var swatches_selected = [null, null]

func new_palette():
	var r = 0.0
	var g = 0.0
	var b = 0.0
	var current_colour = [-1,-1,-1]
	var x = 0
	while x < PALETTE_SIZE:
		if COLOUR_DEPTH <=2:
			COLOUR_DEPTH = 3
		r = (1.0 / (COLOUR_DEPTH-1)) * (randi_range(0,COLOUR_DEPTH-1))
		g = (1.0 / (COLOUR_DEPTH-1)) * (randi_range(0,COLOUR_DEPTH-1))
		b = (1.0 / (COLOUR_DEPTH-1)) * (randi_range(0,COLOUR_DEPTH-1))
		current_colour = [r,g,b]
		if current_colour not in colour_array:
			#print(colour_array)
			colour_array[x] = current_colour
			x+=1
		current_colour = [-1,-1,-1]

# Called when the node enters the scene tree for the first time.
func _ready():
	normal_button.normal_selected.connect(_on_normal_pressed)
	hard_button.hard_selected.connect(_on_hard_pressed)
	pass

func _on_normal_pressed():
	selected_difficulty = 0
	start_game()
func _on_hard_pressed():
	selected_difficulty = 1
	start_game


func start_game():
	normal_button.visible = false
	hard_button.visible = false
	$ScoreLabel.visible = true
	$Score.visible = true
	$HighScoreLabel.visible = true
	$HighScore.visible = true
	if selected_difficulty == 0:
		PALETTE_SIZE = 4
		SWATCH_SIZE = 174
	else:
		PALETTE_SIZE = 9
		SWATCH_SIZE = 116
	palette_grid.columns = sqrt(PALETTE_SIZE)
	
	colour_array.resize(PALETTE_SIZE)
	colour_array.fill(null)
	grid_array.resize(PALETTE_SIZE)
	grid_array.fill(null)
	new_palette()
	create_palette()
	create_result()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

		
func create_palette():
	for i in range(PALETTE_SIZE):
		var new_swatch = swatch_scene.instantiate()
		new_swatch.swatch_ID = i
		new_swatch.set_swatch_size(SWATCH_SIZE)
		#print(colour_array)
		#print(new_swatch.swatch_ID)
		new_swatch.set_background(colour_array[new_swatch.swatch_ID])
		new_swatch.swatch_selected.connect(_on_swatch_selected)
		palette_grid.add_child(new_swatch)
		grid_array[i] = new_swatch
	print(grid_array[0].get_background)
	
func _on_swatch_selected(swatch):
	print(swatch.swatch_ID)
	if swatches_selected[0] == null:
		swatches_selected[0] = swatch.swatch_ID
	else:
		if swatches_selected[1] == null && swatch not in swatches_selected:
			swatches_selected[1] = swatch.swatch_ID
		else:
			pass
	check_correct()
	print(swatches_selected)

func reset_palette():
	new_palette()
	swatches_selected = [null, null]
	for i in range(PALETTE_SIZE):
		grid_array[i].set_background(colour_array[grid_array[i].swatch_ID])
	create_result()

func check_correct():
	if swatches_selected[0] != null && swatches_selected[1] != null:
		if swatches_selected[0] in correct_swatches && swatches_selected[1] in correct_swatches:
			print("correct")
			score+=1
		else:
			print("incorrect")
			if score>highscore: highscore=score
			score=0
		reset_palette()
		score_node.text = str(score)
		highscore_node.text = str(highscore)
		
func create_result():
	var current_rand = -1
	correct_swatches = [randi_range(0,PALETTE_SIZE-1),randi_range(0,PALETTE_SIZE-1)]
	while correct_swatches[1] == correct_swatches[0]:
		correct_swatches[1] = randi_range(0,PALETTE_SIZE-1)
	
	var new_r = (grid_array[correct_swatches[0]].get_background().r
	+ grid_array[correct_swatches[1]].get_background().r) / 2
	var new_g = (grid_array[correct_swatches[0]].get_background().g
	+ grid_array[correct_swatches[1]].get_background().g) / 2
	var new_b = (grid_array[correct_swatches[0]].get_background().b
	+ grid_array[correct_swatches[1]].get_background().b) / 2

	$Result.color = Color(new_r, new_g, new_b)
	print(correct_swatches)
	print(colour_array[correct_swatches[0]], colour_array[correct_swatches[1]])
	

