extends UnlimitRange

class_name LimitRange

func _init():
	
	if not on_change_min_value.is_connected(_on_change_min_value):
		on_change_min_value.connect(_on_change_min_value)
	
	if not on_change_max_value.is_connected(_on_change_max_value):
		on_change_max_value.connect(_on_change_max_value)
		
	#super._init(min_val, max_val)

func is_in_range(value: float) -> bool:
	return value >= min_value && value <= max_value

func _on_change_min_value() -> void:
	if min_value > max_value:
		var temp = max_value
		max_value = min_value
		min_value = temp

func _on_change_max_value() -> void:
	if max_value < min_value:
		var temp := min_value
		min_value = max_value
		max_value = temp
