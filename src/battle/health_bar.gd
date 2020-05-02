extends TextureProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	value = PlayerStore.health
	pass # Replace with function body.

func _on_camera_and_hud_health_change(amount):
	value -= amount
	pass # Replace with function body.
