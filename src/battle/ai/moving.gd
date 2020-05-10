extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var rng = RandomNumberGenerator.new()

onready var path_follow = $"../../../Path2D/PathFollow2D"
onready var path_2d = $"../../../Path2D"
onready var paths = [
	"../../../left_path", "../../../slight_left_path", "../../../straight_path",
	"../../../slight_right_path", "../../../right_path"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var next_curve = Curve2D.new()
	next_curve.add_point(Vector2.ZERO)
	var x = rng.randi_range(0,4)
	print(x)
	next_curve.add_point(Vector2.ZERO + get_node(paths[x]).position)
	path_2d.set_curve(next_curve)



func physics(scorpion) -> String:
	path_follow.offset += 1
	scorpion.position = path_follow.position
	scorpion.rotation = path_follow.rotation
	if path_follow.unit_offset == 1:
		path_follow.unit_offset = 0
		rng.randomize()
		var next_curve = Curve2D.new()
		next_curve.add_point(scorpion.position)
		var x = rng.randi_range(0,4)
		print(x)
		next_curve.add_point(scorpion.position + get_node(paths[x]).position)
		path_2d.set_curve(next_curve)
	return "moving"
