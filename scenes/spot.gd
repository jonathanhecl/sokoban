extends Area2D

const COLOR_FREE = "00ff04"
const COLOR_OCCUPED = "ffffff"

@onready var rect = $RectSpot
var occupied = false

func _onready():
	rect.color = COLOR_FREE

func _on_body_entered(body):
	if body.is_in_group("box"):
		rect.color = COLOR_OCCUPED
		occupied = true


func _on_body_exited(body):
	if body.is_in_group("box"):
		rect.color = COLOR_FREE
		occupied = false
