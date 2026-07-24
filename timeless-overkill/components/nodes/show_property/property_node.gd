@abstract
extends Node

class_name PropertyNode

var node: Node
@export var data: ShowPropertyNodeData

func _ready() -> void:
	assert(_verify_self_type(), "The node" + self.name + "is not of the correct type!")
	node = get_node(data.node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if not node:
		return
	
	assert(data.properties.size() > 0, "You can't leave properties array empty")
	
	for method in data.properties:
		
		assert(self.has_method(method), 'This node don\'t have the method "' + method + '"!')
		
		var props := data.properties[method]
		
		for prop in props:
			assert(prop is String, "This node have a property that not is a String!a")
			
			self.call(method, node.get_indexed(prop))

@abstract
func _verify_self_type() -> bool
