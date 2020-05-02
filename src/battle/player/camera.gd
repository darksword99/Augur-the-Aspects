extends Position2D

# The camera_distance_multiplyer is multiplyed by the player movement to 
# make the camera go in front of the player as they are moveing.
var camera_distance_multiplyer = 0.5
signal health_change
# Called when the node enters the scene tree for the first time.
func _ready():
	update_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	update_position()

func update_position():
	position = get_parent().movement * camera_distance_multiplyer

func _on_player_entered_idle():
	$hud_canvas_layer/mana_health_box/mana_bar.player_idle = true

func _on_player_exited_idle():
	$hud_canvas_layer/mana_health_box/mana_bar.player_idle = false

func _on_staggered_health_change(amount):
	emit_signal("health_change", amount)

func _on_moving_health_change(amount):
	emit_signal("health_change", amount)

func _on_idle_health_change(amount):
	emit_signal("health_change", amount)

func _on_casting_health_change(amount):
	emit_signal("health_change", amount)
