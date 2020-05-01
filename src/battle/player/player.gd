#
# res://src/battle/player.gd
# player script during battle
#

extends KinematicBody2D

# currently used for max speed
export var speed: int = 100
# holds a vector for camera use
export var movement: Vector2

var health: int
var equipped_spells: Dictionary
var velocity: Vector2
var current_state: String

onready var stagger_timer = $stagger_timer
onready var joystick = $camera_and_hud/hud_canvas_layer/joystick/joystick_button
onready var animate_tree = $animation_tree

onready var states_map = {
	"staggered": $states/staggered,
	"moving": $states/moving,
	"idle": $states/idle,
	"casting": $states/casting,
}

func _ready():
	#initalized health and equipped_spells from last save state
	health = PlayerStore.health
	equipped_spells = PlayerStore.equipped_spells
	
	#sets inital velocity and current state
	velocity = Vector2.ZERO
	current_state = "idle"

func _physics_process(_delta: float):
	# defers the call to the script accosiated with the current state
	# uses the joystick value to determine movement
	var new_state = states_map[current_state].physics(self, joystick.get_value(), animate_tree)
	_change_state(new_state)

# changes state, we will eventually add animations with this function
func _change_state(new_state: String):
	if new_state != current_state:
		states_map[current_state].on_exit_state()
		states_map[new_state].on_enter_state()
		current_state = new_state

# differs taking damage to the state the player is in
func take_damage(damage: int):
	var new_state = states_map[current_state].take_damage(self, damage)
	_change_state(new_state)

# saves the game with players health
func _update():
	PlayerStore.health = health

func die():
	# TODO: make death do things
	print("player died, F in chat for ya boi")
	pass

# when the player exits stagger
func _on_stagger_timer_timeout():
	_change_state("idle")


func _on_idle_exited_idle():
	pass # Replace with function body.
