#
# res://src/battle/player/staggered.gd
# handles movement and damage while casting
#
extends Node

signal entered_staggered
signal exited_staggered
signal health_change

func on_enter_state():
	emit_signal("entered_staggered")
	
func on_exit_state():
	emit_signal("exited_staggered")

func physics(player: KinematicBody2D, movement: Vector2) -> String:
	# if joystick moved, player moves in that direction
	if (movement != Vector2.ZERO):
		# move player
		player.movement = player.move_and_slide(movement * player.speed)
	return "staggered"

func take_damage(_player, _damage: int) -> String:
	return "staggered"

func heal(_player, amount: int) -> void:
	emit_signal("health_change", amount)
