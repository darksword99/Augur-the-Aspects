extends Node

var player
var scorpion

func _ready():
	pass # Replace with function body.

func physics(delta) -> String:
	return "beam"


func init(_scorpion, _player):
	scorpion = _scorpion
	player = _player
