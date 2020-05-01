#
# res://src/battle/player/moving.gd
# handles movement and damage while casting
#
extends Node

func physics(player, movement, a_tree) -> String:
	var direction_vector = movement.normalized()
	# next line is pretty bad..
	var a_state = a_tree.get("parameters/playback")
	
	# if joystick moved, player moves in that direction
	if (movement != Vector2.ZERO):
		# do moving animations here
		a_tree.set("parameters/idle_animations/blend_position", direction_vector)
		a_tree.set("parameters/walk_animations/blend_position", direction_vector)
		a_state.travel("walk_animations")
		# move player
		movement = player.move_and_slide(movement * player.speed)
		
	return "staggered"

func take_damage(_player, _damage: int) -> String:
	return "staggered"
