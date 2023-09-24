extends CharacterBody2D

@onready var ray = $RayCast2D
const SIZE_TILE = 32

var inputs = {
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
}

func _unhandled_input(event):
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)
		if event.is_action_released("ui_cancel"):
			get_tree().reload_current_scene()

func move(direction):
	var next_position = inputs[direction] * SIZE_TILE
	var final_position = position + next_position
	ray.target_position = next_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += next_position
		get_parent().moves += 1
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("box"):
			if collider.move(direction):
				position += next_position
				get_parent().moves += 1
