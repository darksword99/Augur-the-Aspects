extends Node


export var RANGE : int= 30
export var damage= 10

var cooldown = .9	#seconds.
var scorpion
var player

var _cooldown = 0	#to keep track of time

func _ready():
	pass # Replace with function body.


func physics(delta) -> String:
	var dist:Vector2 = scorpion.position - player.position
	if dist.length() >= RANGE:
		_cooldown = 0
#		return "beam"
		return "poke"
	else :
		_cooldown -= delta
		if _cooldown <= 0:
			#play poke animation
			player.take_damage(damage)
			print("poke")
			_cooldown = cooldown
		return "poke"


func init(_scorpion, _player):
	scorpion = _scorpion
	player = _player
