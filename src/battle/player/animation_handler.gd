extends Node

var state: String
onready var anim_tree: AnimationTree = $animation_tree

func _ready():
	# this is a fix for having the console spammed with warnings
	anim_tree.active = true

func _process(_delta):
	# gets the animation state machine 
	var animation_state = anim_tree.get("parameters/playback")
	# decides what to be played
	if state == "moving":
		# gets the normalized vector of the joystick
		var joystick_direction = get_parent().joystick.get_value().normalized()
		# decides what direction the animation will be played
		anim_tree.set("parameters/idle_animations/blend_position", joystick_direction)
		anim_tree.set("parameters/walk_animations/blend_position", joystick_direction)
		animation_state.travel("walk_animations")
	elif state == "idle":
		animation_state.travel("idle_animations")
	else:
		# this is where extra states should be added.
		pass

func _on_player_entered_staggered():
	state = "staggered"

func _on_player_entered_idle():
	state = "idle"

func _on_player_entered_casting():
	state = "casting"

func _on_player_entered_moving():
	state = "moving"

