#
# res://src/battle/player/moving.gd
# handles movement and damage while casting
#
extends Node

func physics(player, mouse_pos, delta) -> String:
	# insert your fancy movement here (and in other states where applicable)
	player.velocity = mouse_pos - player.position

	# check to see if its worth moving
	if player.velocity.length() > 5:
		# move the player
		player.position += player.velocity.normalized() * player.speed * delta
	return "staggered"

func take_damage(_player, _damage: int) -> String:
	return "staggered"
