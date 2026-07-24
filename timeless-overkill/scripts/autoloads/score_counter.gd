extends Node

signal score_changed(new_score: int)

## Actual Score
var score := 0:
	set(value):
		
		if value < 0:
			value = 0
		
		if score != value:
			score = value
			score_changed.emit(score)

func reset_score() -> void:
	score = 0
