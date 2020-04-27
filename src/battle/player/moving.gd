#
# res://src/battle/player/moving.gd
# handles movement and damage while moveing
#
extends Node


func physics(player: KinematicBody2D, mouse_pos: Vector2, delta: float) -> String:
	# insert your fancy movement here (and in other states where applicable)
	player.velocity = mouse_pos - player.position
	# check to see if its worth moving
	if player.velocity.length() < 5:
		# return the new state
		return "idle"
	else:
		# move the player
		player.position += player.velocity.normalized() * player.speed * delta
		return "moving"

func take_damage(player: KinematicBody2D, damage: int) -> String:
	# starts the timer for stagger to end
	player.stagger_timer.start(0.1)
	# player takes damage and checks if they are still alive
	player.health -= damage
	if player.health <= 0:
		player.die()
	# return the new state
	return "staggered"
