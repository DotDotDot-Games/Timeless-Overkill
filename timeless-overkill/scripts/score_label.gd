extends RichTextLabel

const TEXT_UNFORMATTED := "Score: %d"
@onready var color_rect : ColorRect = $".."
func _ready() -> void:
	
	if not ScoreCounter.score_changed.is_connected(_on_change_score):
		ScoreCounter.score_changed.connect(_on_change_score)
	
	_on_change_score(ScoreCounter.score)
	
func _on_change_score(new_score: int) -> void:
	self.text =  "[wave][rainbow]"+"Score: "+str(new_score)+"[/rainbow][/wave]"
	
	await get_tree().process_frame
	var s := size + Vector2(10,0)
	color_rect.custom_minimum_size = s
	color_rect.custom_maximum_size = s
	color_rect.size = s
	

func _input(event: InputEvent) -> void:
	
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed("DEBUG_SCORE"):
		ScoreCounter.score += 10
