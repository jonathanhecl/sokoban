extends Node2D

var game_end = false
var moves = 0

func _process(delta):
	if game_end:
		return
	$MovesLabel.text = "Moves: " + str(moves)
	var spots = $Spots.get_child_count()
	for i in $Spots.get_children():
		if i.occupied:
			spots -= 1

	if spots == 0:
		print("VICTORY, total moves: " + str(moves))
		get_tree().reload_current_scene()
		game_end = true
		
