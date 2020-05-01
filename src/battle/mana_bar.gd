extends Control


export var number_of_segments: int  = 3 # Minimum value is 1

var mana_total = 0 # Each segment contains 38 max mana
var list_of_segments = []
var player_idle = true

func _ready():
	var h_box = $HBoxContainer
	list_of_segments.append($HBoxContainer/mana_bar_segment)
	
	# Creates a number of segements based on number_of_segments variable.
	# Adds all segments to list_of_segments, and adds all segemts as childs of
	# the HBoxContainer. 
	while len(list_of_segments) < number_of_segments:
		var new_segment = $HBoxContainer/mana_bar_segment.duplicate()
		h_box.add_child(new_segment)
		list_of_segments.append(new_segment)


# Called when a spell is cast. 
# Variable "cost" is the number of mana bar segments it costs to cast the spell.
func spell_cast(cost):
	var cost_value: int = 38 * cost
	print(cost_value, " ", mana_total)
	if cost_value > mana_total:
		# If the player does not have enough mana to cast what they want to
		# cast, this code will run. For now there is this temporary error
		# message, but more functionality could be added here later on.
		print("ERROR: Not enough mana to cast spell")  
	else:
		mana_total -= cost_value 
		
		var index = len(list_of_segments)-1
		while cost_value > 0:
			cost_value -= list_of_segments[index].value - 6
			if cost_value > 0:
				list_of_segments[index].value = 6
			else:
				list_of_segments[index].value = 6 - cost_value
			index -= 1


# This function repeats every 0.08 seconds based on this scenes timer node.
# Adds mana to the mana bar if the player is idle.
func _on_Timer_timeout() -> void:
	if player_idle:
		for i in list_of_segments:
			if i.value < 44:
				i.value += 1
				mana_total += 1
				break
