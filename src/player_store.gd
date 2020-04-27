#
# res://src/player_store.gd
# Store of player information, to be saved upon close
#

extends Node

var health: int
# {Item: Amount}
var inventory: Dictionary
# {Spell: Amount}
var equipped_spells: Dictionary

func stringify():
	pass

# underscore is temporary so I get a less busy debugger
func parse(_data: String):
	pass

func _init():
	pass
