#
# src/player_store.gd
# Store of player information, to be saved upon close
#

var health: int
# {Item: Amount}
var inventory: Dictionary
# {Spell: Amount}
var equipped_spells: Dictionary

func stringify():
    pass

func parse(data: String):
    pass

func _init():
    pass
