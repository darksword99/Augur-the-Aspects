extends KinematicBody2D


var movement = Vector2.ZERO
var speed = 50
var facing = Vector2(1,1)
var current_state = "aboveground"
var handling = PI/64
var next_angle = 0

var rng = RandomNumberGenerator.new()
onready var navigation = $Navigation2D
onready var player = $"../../../player" # Instance of relying on things outside of current scene


func _ready() -> void:
	rng.randomize()
	print(rng.randi_range(1,10))


func _process(delta: float) -> void:
	pass
	
#	movement = Vector2(1, tan(facing.angle() + handling))
	
	facing = movement.normalized()
	movement = movement.normalized() * speed
	move_and_slide(movement)


func change_state(new_state: String) -> void:
	if new_state != current_state:
		current_state = new_state
