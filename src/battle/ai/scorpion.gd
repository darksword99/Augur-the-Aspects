extends KinematicBody2D


var movement = Vector2.ZERO
var speed = 50
var facing = Vector2(1,1)
var current_state = "poke"
var handling = PI/64
var next_angle = 0

var rng = RandomNumberGenerator.new()
onready var navigation = $Navigation2D
onready var player :KinematicBody = $"../player" # Instance of relying on things outside of current scene
onready var path_follow = $"../p"
onready var states_map = {
	"charging": $states/underground/charging,
	"moving": $states/underground/moving,
	"poke": $states/aboveground/attacking/poke,
	"beam": $states/aboveground/attacking/beam,
}

func _ready() -> void:
	for state in states_map:
		states_map[state].init(self, player)


func _process(delta: float) -> void:
	var new_state = states_map[current_state].physics(delta)
	change_state(new_state)



func change_state(new_state: String) -> void:
	if new_state != current_state:
		current_state = new_state
