extends RichTextLabel

const TEXT_UNFORMATTED := "Score: %d"
@onready var color_rect : ColorRect = $".."
@onready var timer : Timer = $"../Timer"
var global_score := 0
@onready var color_rect_bar : ColorRect = $"../../../../ColorRect"
var start_time := 0.0
func _ready() -> void:
	
	if not ScoreCounter.score_changed.is_connected(_on_change_score):
		ScoreCounter.score_changed.connect(_on_change_score)
	
	_on_change_score(ScoreCounter.score)
	
func _process(_delta):
	color_rect_bar.size.x = color_rect.size.x * 2 * (timer.time_left / start_time)
	
func _on_change_score(new_score: int) -> void:
	color_rect_bar.size.y = color_rect.size.y + 25
	
	ScoreCounter.score_rainbow_mult += 0.2
	global_score = new_score
	timer.start()
	start_time = timer.wait_time
	self.text = "[wave][rainbow]"+"Score: "+str(new_score)+"[/rainbow][/wave]"
	await get_tree().process_frame
	var s := size + Vector2(10,0)
	color_rect.custom_minimum_size = s
	color_rect.custom_maximum_size = s
	color_rect.size = s
	await get_tree().create_timer(2).timeout
		
	
	

func _input(event: InputEvent) -> void:
	
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed("DEBUG_SCORE"):
		ScoreCounter.score += 10


func _on_timer_timeout() -> void:
	self.text = "[wave]"+"Score: "+str(global_score)+"[/wave]"
	ScoreCounter.score_rainbow_mult =1
