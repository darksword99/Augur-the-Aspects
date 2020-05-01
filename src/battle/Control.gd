extends Control


var number_of_segments = 3 # Minimum value is 1

var mana_total = 0 # Each segment contains 38 mana.
var list_of_segments = []
var player_idle = true
var under_texture_path = "res://assets/hud/mana_bar_empty.png"
var progress_texture_path = "res://assets/hud/mana_bar_full.png"
var states = ["staggered","moving","idle","casting"]


func _ready() -> void:
	var h_box = get_node("HBoxContainer")
	var under_texture = load(under_texture_path)
	var progress_texture = load(progress_texture_path)
	
	# Creates a number of segements based on number_of_segments variable.
	# Adds all segments to list_of_segments, and adds all segemts as childs of
	# the HBoxContainer. 
	for i in range(number_of_segments):
		var new_segment = TextureProgress.new()
		new_segment.set_under_texture(under_texture)
		new_segment.set_progress_texture(progress_texture)
		new_segment.max_value = 50
		# new_segment's value is set to 6 because the blue part of the mana bar
		# segment does not start at the very edge of the image. So this offset 
		# is nessisary to have the mana bar segments fill up correctly.
		new_segment.value = 6
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


# Signal got from player stops and starts the timer depending on wether the
# player is idle.
func _on_player_player_state_update(state):
	if state == states[1]:
		$Timer.stop()
	elif state == states[2]:
		$Timer.start()
