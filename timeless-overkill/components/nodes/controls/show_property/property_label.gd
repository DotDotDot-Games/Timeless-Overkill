extends Label

class_name PropertyLabel

@export var node: Node
@export var property: StringName
var _getter := PropertyGetter.new()

func _process(_delta):
	
	var _value = _getter.process(node, property)
	
	if !_value:
		return
		
	self.text = format(_value)

func format(val: Variant) -> String:
	
	if val is Object:
		val = val.to_string()
	
	return str(val)
