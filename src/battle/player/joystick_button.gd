extends TouchScreenButton

var radius = Vector2(20, 20)	# Radius of the button
var max_dist = 18 				# How far the button can be dragged from center
var drag = -1					# Tracks which pointer is touching the screen
var snap_accel = 20				# Accel for button to snap back to center

# Min dist to move joystick from center for each movement
var run_threshold = 16			
var walk_threshold = 8
var sneak_threshold = 4		
# Movement factors when walking/sneaking
const WALK_CONST = 0.5			
const SNEAK_CONST = 0.1


func get_button_pos():
	return position + radius
	
# Done each frame
func _process(delta):
	if (drag == -1):
		# return button to the center
		var pos_diff = (Vector2.ZERO - radius) - position
		position += pos_diff * snap_accel * delta
		

func _input(event):
	# check for if button is being dragged or pressed (for mobile devices)
	# in project settings > input devices > pointing, check "emulate touch from mouse"
	if (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed())):
		# sets center of joystick background to click location
		if event is InputEventScreenTouch:
			get_parent().global_position = event.position
			get_parent().show()
		
		set_global_position(event.position - radius * global_scale)
		
		# keeps button position within the radius of the joystick background
		if (get_button_pos().length() > max_dist):
			set_position(get_button_pos().normalized() * max_dist - radius)
		
		# keeps track of which pointer caused the movement
		drag = event.get_index()
	
	# if pointer released, we reset the drag and hide the Joystick
	if (event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == drag):
		drag = -1
		# for some reason setting visiblity to false or using .hide() sets process_input to false
		get_parent().visible = false
		set_process_input(true)
		


func get_value():
	var movement: Vector2
	# running speed (past run_threshold radius on joystick)
	if (get_button_pos().length() > run_threshold):
		movement = get_button_pos().normalized()
	# walking speed (past walk_threshold radius on joystick)
	elif (get_button_pos().length() > walk_threshold):
		movement = get_button_pos().normalized() * 0.5
	# sneak speed (past sneak_threshold radius on joystick)
	elif (get_button_pos().length() > sneak_threshold):
		movement = get_button_pos().normalized() * 0.1
	else:
		movement = Vector2.ZERO
	
	return movement
