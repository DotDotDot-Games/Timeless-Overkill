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
	
	if not ScoreCounter.mult_changed.is_connected(_on_change_score):
		ScoreCounter.mult_changed.connect(func(new_mult: float): _on_change_score(ScoreCounter.score, false))
	
	_on_change_score(ScoreCounter.score, false)
	
func _process(_delta):
	color_rect_bar.size.x = color_rect.size.x * 2 * (timer.time_left / start_time)

func add_commas(number: int) -> String:
	var s := str(number)
	var result := ""
	var count := 0
	
	for i in range(s.length() - 1, -1, -1):
		result = s[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	
	return result
func _on_change_score(new_score: int, more_mult := true) -> void:
	color_rect_bar.size.y = color_rect.size.y + 25
	

	global_score = new_score
	timer.start()
	start_time = timer.wait_time
	self.text = "[color=#F6BE00]"+str(ScoreCounter.score_rainbow_mult)+"x [/color]"+ "[wave][rainbow]"+"Score: "+add_commas(int(snappedf(new_score,100)))+"[/rainbow][/wave]"
	await get_tree().process_frame
	
	if more_mult:
		ScoreCounter.score_rainbow_mult += 0.2
	
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
	self.text = "[color=#F6BE00]1x [/color]"+"[wave]"+"Score: "+add_commas(int(snappedf(global_score,100)))+"[/wave]"
	ScoreCounter.score_rainbow_mult =1
