extends Control


var number_of_segments = 3

var list_of_segments = []
var player_idle = true
var under_texture_path = "res://assets/hud/Mana Bar 0 Thirds.png"
var progress_texture_path = "res://assets/hud/Mana Bar 3 Thirds.png"


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
		h_box.add_child(new_segment)
		list_of_segments.append(new_segment)


func _on_Timer_timeout() -> void:
	if player_idle:
		for i in list_of_segments:
			if i.value < 50:
				i.value += 1
				break
