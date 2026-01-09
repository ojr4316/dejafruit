class_name InteractableArea extends Area3D

signal interaction_started
signal interaction_ended

func _ready() -> void:
	area_entered.connect(_area_entered)
	area_exited.connect(_area_exited)
	
	set_process_unhandled_input(false)

func _area_entered(area: Area3D) -> void:
	if area is InteractorArea:
		set_process_unhandled_input(true)
	
func _area_exited(area: Area3D) -> void:
	if area is InteractorArea:
		set_process_unhandled_input(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interaction_started.emit()
	elif event.is_action_released("interact"):
		interaction_ended.emit()
