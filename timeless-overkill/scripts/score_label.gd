extends Label

const TEXT_UNFORMATTED := "Score: %d"

func _ready() -> void:
	
	if not ScoreCounter.score_changed.is_connected(_on_change_score):
		ScoreCounter.score_changed.connect(_on_change_score)
	
	_on_change_score(ScoreCounter.score)
	
func _on_change_score(new_score: int) -> void:
	self.text = TEXT_UNFORMATTED % [new_score]

func _input(event: InputEvent) -> void:
	
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed("DEBUG_SCORE"):
		ScoreCounter.score += 10
