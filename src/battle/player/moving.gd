#
# res://src/battle/player/moving.gd
# handles movement and damage while moving
#
extends Node

signal entered_moving
signal exited_moving
signal health_change

func on_enter_state():
	emit_signal("entered_moving")
	
func on_exit_state():
	emit_signal("exited_moving")


func physics(player: KinematicBody2D, movement: Vector2) -> String:
	# if joystick moved, player moves in that direction
	if (movement != Vector2.ZERO):
		# move player, apply vector to movement property
		player.movement = player.move_and_slide(movement * player.speed)
		return "moving"
	else:
		return "idle"

func take_damage(player: KinematicBody2D, damage: int) -> String:
	# starts the timer for stagger to end
	player.stagger_timer.start(0.1)
	# player takes damage and checks if they are still alive
	player.health -= damage
	if player.health <= 0:
		player.die()
		
	# emit signal for damage
	emit_signal("health_change", damage)
	
	# return the new state
	return "staggered"

func heal(_player, amount: int) -> void:
	emit_signal("health_change", amount)
