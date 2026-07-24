extends Resource

class_name ShowPropertyNodeData

@export var node: NodePath

## Key: Function to call
## Value: Properties of the node to call the function (one by one)
@export var properties: Dictionary[StringName, Array] = {}
