extends Node

var score_player_one = 0
var score_player_two = 0

func _ready():
	$Ball.set_start_direction()


func _on_Field_goal_left():
	score_player_two += 1


func _on_Field_goal_right():
	score_player_one += 1
