#
# res://src/battle/player/idle.gd
# handles movement and damage while moveing
#
extends Node

signal entered_idle
signal exited_idle

func on_enter_state():
	emit_signal("entered_idle")
	
func on_exit_state():
	emit_signal("exited_idle")


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
		# move player, apply vector to movement property
		player.movement = player.move_and_slide(movement * player.speed)
		return "moving"
		
	else:
		# do idle animations here
		animation_state.travel("idle_animations")
		return "idle"

func take_damage(player: KinematicBody2D, damage: int) -> String:
	
	# starts the timer for stagger to end
	player.stagger_timer.start(0.1)

	# player takes damage and checks if they are still alive
	player.health -= damage
	if player.health <= 0:
		player.die()

	# return the new state
	return "staggered"
	
