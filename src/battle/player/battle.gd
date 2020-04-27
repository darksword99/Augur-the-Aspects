#
# res://src/battle/battle.gd
# Main script for battle scene
#

extends Node2D

enum FightState {DODGE,CAST}

var velocity: Vector2

var current_state: Dictionary = {
	"fight_state": null,
	"player": null,
	"enemies": []
}

func _ready():
	current_state["fight_state"] = FightState.DODGE
	velocity = Vector2(0,0)
	
func change_fight_state(fight_state_str: String):
	if fight_state_str == "dodge":
		current_state["fight_state"] = FightState.DODGE
	elif fight_state_str == "cast":
		current_state["fight_state"] = FightState.CAST
	else:
		print("not a valid fight_state" + fight_state_str)

func update():
	for child in get_children():
		if child.has_func("update"):
			child.update()
