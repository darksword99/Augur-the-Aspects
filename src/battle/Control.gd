extends Control

onready var bar1 = $"HBoxContainer/mana_bar_1"
onready var bar2 = $"HBoxContainer/mana_bar_2"
onready var bar3 = $"HBoxContainer/mana_bar_3"


func _on_Timer_timeout() -> void:
	if bar1.value < 50:
		bar1.value += 1
	elif bar2.value < 50:
		bar2.value += 1
	elif bar3.value < 50:
		bar3.value += 1
