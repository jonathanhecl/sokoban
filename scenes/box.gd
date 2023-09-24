extends CharacterBody2D

@onready var ray = $RayCast2D
const SIZE_TILE = 32

var inputs = {
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
}

func move(direction):
	var next_position = inputs[direction] * SIZE_TILE
	ray.target_position = next_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += next_position
		return true
	return false
