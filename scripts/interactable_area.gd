class_name InteractableArea extends Area3D

@export var interactable: Interactive

signal interaction_started(invert: bool)
signal interaction_ended(invert: bool)

var interactor: InteractorArea = null

func _ready() -> void:
	area_entered.connect(_area_entered)
	area_exited.connect(_area_exited)
	
	set_process_unhandled_input(false)

func _area_entered(area: Area3D) -> void:
	if area is InteractorArea:
		set_process_unhandled_input(true)
		interactor = area
		interactor.player.ui.show_interactor(interactable.get_interact_text())
		
	
func _area_exited(area: Area3D) -> void:
	if area is InteractorArea:
		set_process_unhandled_input(false)
		interactor.player.ui.hide_interactor()
		interactor = null
	
func _unhandled_input(event: InputEvent) -> void:
	var invert := interactor.global_basis.tdotz(global_basis.z) < 0
	
	if event.is_action_pressed("interact"):
		interaction_started.emit(invert)
		interactor.player.ui.show_interactor(interactable.get_interact_text())
	elif event.is_action_released("interact"):
		interaction_ended.emit(invert)
		interactor.player.ui.show_interactor(interactable.get_interact_text())
