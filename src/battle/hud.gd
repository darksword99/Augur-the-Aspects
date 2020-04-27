extends Control


var mana_bars_filled: int
var mana_charge: int
var health: int

func _ready():
	health = PlayerStore.health
	mana_bars_filled = 0
	mana_charge = 0

