extends ProgressBar

@onready var player: PlayerNode = get_tree().get_first_node_in_group("Players")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_value = player.max_health
	
	if not player.health_changed.is_connected(_set_health):
		player.health_changed.connect(_set_health)
	
	_set_health(player.health)
	
func _set_health(player_health: int) -> void:
	self.value = player_health
