#
# res://src/battle/player/casting.gd
# handles movement and damage while casting
#

extends Node

signal entered_casting
signal exited_casting

func on_enter_state():
	emit_signal("entered_casting")
	
func on_exit_state():
	emit_signal("exited_casting")

# as player can't move or take damage during casting, this is a boring script
func physics(_player: KinematicBody2D, _movement: Vector2) -> String:
	return "casting"

func take_damage(_player, _damage: int) -> String:
	return "casting"
