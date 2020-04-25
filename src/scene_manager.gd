#
# src/scene_manager.gd
# Controls what root scene the game is in
#

extends Node2D

var scene_list: Dictionary = {
    "menu": "res://src/menu/main.tscn",
    "map": "res://src/map/main.tscn",
    "battle": "res://src/battle/main.tscn"
}

func scene_change(scene_path: String):
    return get_tree().change_scene(scene_list[scene_path])

func _init():
    scene_change("menu")
