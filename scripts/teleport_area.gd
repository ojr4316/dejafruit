class_name TeleportArea extends Area3D

@export var destination: Marker3D

func _ready() -> void:
	body_entered.connect(_body_entered)
	
func _body_entered(body: Node3D) -> void:
	if body is Player:
		transition(body)

func transition(player: Player) -> void:
	var relative := player.global_position - global_position
	player.global_position = destination.global_position + relative
	AnomalyManager.start_random()
	
