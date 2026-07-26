@abstract
extends ShareableResource

class_name BaseNodeSpawnMethod

@abstract
func create() -> Node2D

func had_node_to_spawn() -> bool:
	return true
