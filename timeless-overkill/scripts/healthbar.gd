extends ProgressBar

var parent

func _ready():
	parent = get_parent()
	global_position = parent.global_position + Vector2(-size.x/2,-40)
	max_value = parent.max_health
	value = parent.health
	
func _process(_delta):
	parent = get_parent()
	value = parent.health
