#
# res://src/scene_manager.gd
# Controls what root scene the game is in
#

extends Node2D

var scene_list: Dictionary = {
	"menu": "res://src/menu/main.tscn",
	"map": "res://src/map/main.tscn",
	"battle": "res://src/battle/main.tscn"
}

func change_scene(scene_path: String):
	for child in get_children():
		# saves state of scene we are leaving
		if child.has_method("update"): child.update()
		# removes prev scene and children
		child.queue_free()

	# appends new scene underneath the scene manager
	add_child(load(scene_list[scene_path]).instance())

func _ready():
	change_scene("menu")
