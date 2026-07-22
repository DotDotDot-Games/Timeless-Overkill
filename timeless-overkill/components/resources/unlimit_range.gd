extends ShareableResource

class_name UnlimitRange

signal on_change_max_value
signal on_change_min_value

@export var _min_value: float
@export var _max_value: float

var min_value: float:
	get: return _min_value
	set(value):
		_min_value = value
		on_change_min_value.emit()

var max_value: float:
	get: return _max_value
	set(value):
		_max_value = value
		on_change_max_value.emit()

func is_in_range(value: float) -> bool:
	return value >= min_value && value <= max_value
