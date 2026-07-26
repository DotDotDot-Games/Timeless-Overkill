extends Node

signal score_changed(new_score: int)
signal mult_changed(new_mult: float)

var score_rainbow_mult := 1.0:
	set(value):
		
		if value < 1.0:
			return
		
		if value == score_rainbow_mult:
			return
		
		score_rainbow_mult = value
		mult_changed.emit(score_rainbow_mult)

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
	score_rainbow_mult = 1
	
