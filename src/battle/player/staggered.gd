#
# res://src/battle/player/staggered.gd
# handles movement and damage while casting
#
extends Node

signal entered_staggered
signal exited_staggered

func on_enter_state():
	emit_signal("entered_staggered")
	
func on_exit_state():
	emit_signal("exited_staggered")

func physics(player: KinematicBody2D, movement: Vector2, animation_tree: AnimationTree) -> String:
	var direction_vector = movement.normalized()
	# next line is pretty bad..
	var animation_state = animation_tree.get("parameters/playback")
	
	# if joystick moved, player moves in that direction
	if (movement != Vector2.ZERO):
		# do moving animations here
		animation_tree.set("parameters/idle_animations/blend_position", direction_vector)
		animation_tree.set("parameters/walk_animations/blend_position", direction_vector)
		animation_state.travel("walk_animations")
		# move player
		player.movement = player.move_and_slide(movement * player.speed)
		
	return "staggered"

func take_damage(_player, _damage: int) -> String:
	return "staggered"
