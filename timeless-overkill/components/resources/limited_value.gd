extends LimitRange

class_name LimitedValue

signal on_change_current_value

@export var _current_value: float

var current_value: float:
	get: return _current_value
	set(value):
		
		if value == current_value:
			return
		
		_current_value = value
		on_change_current_value.emit()

func _init():
	if not on_change_min_value.is_connected(_update_current):
		on_change_min_value.connect(_update_current)
	
	if not on_change_max_value.is_connected(_update_current):
		on_change_max_value.connect(_update_current)
	
	if not on_change_current_value.is_connected(_update_current):
		on_change_current_value.connect(_update_current)

func _update_current():
	#print(min_value, max_value, current_value)
	current_value = clampf(current_value, min_value, max_value)
