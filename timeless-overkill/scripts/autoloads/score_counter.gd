extends Node

## Actual Score
var score := 0:
	set(value):
		
		if value < 0:
			value = 0
		
		score = value

func reset_score() -> void:
	score = 0
