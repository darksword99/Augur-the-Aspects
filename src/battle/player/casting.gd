#
# res://src/battle/player/casting.gd
# handles movement and damage while casting
#

extends Node

# as player can't move or take damage during casting, this is a boring script
func physics(_player, _mouse_pos, _delta) -> String:
	return "casting"

func take_damage(_player, _damage: int) -> String:
	return "casting"
