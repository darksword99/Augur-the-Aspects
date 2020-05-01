extends Node

var state: String
onready var anim_tree = $animation_tree

func _physics_process(_delta):
	var animation_state = anim_tree.get("parameters/playback")
	if state == "moving":
		var joystick_direction = get_parent().joystick.get_value().normalized()
		anim_tree.set("parameters/idle_animations/blend_position", joystick_direction)
		anim_tree.set("parameters/walk_animations/blend_position", joystick_direction)
		animation_state.travel("walk_animations")
	elif state == "idle":
		animation_state.travel("idle_animations")
	else:
		print("bad things")

func _on_player_entered_staggered():
	state = "staggered"

func _on_player_entered_idle():
	state = "idle"

func _on_player_entered_casting():
	state = "casting"

func _on_player_entered_moving():
	state = "moving"

