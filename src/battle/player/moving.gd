#
# res://src/battle/player/moving.gd
# handles movement and damage while moveing
#
extends Node

func physics(player: KinematicBody2D, movement: Vector2, a_tree: AnimationTree) -> String:
	var direction_vector = movement.normalized()
	# next line is pretty bad..
	var a_state = a_tree.get("parameters/playback")
	
	# if joystick moved, player moves in that direction
	if (movement != Vector2.ZERO):
		# do moving animations here
		a_tree.set("parameters/idle_animations/blend_position", direction_vector)
		a_tree.set("parameters/walk_animations/blend_position", direction_vector)
		a_state.travel("walk_animations")
		# move player, apply vector to movement property
		player.movement = player.move_and_slide(movement * player.speed)
		return "moving"
		
	else:
		# do idle animations here
		a_state.travel("idle_animations")
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
