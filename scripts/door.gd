class_name Door extends Interactive

signal opened
signal closed

const DEGREES_OPEN := 120

@export var left_door: AnimatableBody3D
@export var right_door: AnimatableBody3D

@export var door_opening_time: float = 1

var is_open := false

var active_tween: Tween = null

func open(invert_direction := false) -> void:
	if active_tween: active_tween.stop()
	active_tween = create_tween()
	active_tween.set_parallel()
	
	if left_door: active_tween.tween_property(left_door, "rotation_degrees:y", -DEGREES_OPEN if invert_direction else DEGREES_OPEN, door_opening_time).set_trans(Tween.TRANS_CUBIC)
	if right_door: active_tween.tween_property(right_door, "rotation_degrees:y", DEGREES_OPEN if invert_direction else -DEGREES_OPEN, door_opening_time).set_trans(Tween.TRANS_CUBIC)
	is_open = true
	
	await active_tween.finished
	opened.emit()


func close() -> void:
	if active_tween: active_tween.stop()
	active_tween = create_tween()
	active_tween.set_parallel()
	
	if left_door: active_tween.tween_property(left_door, "rotation_degrees:y", 0, door_opening_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	if right_door: active_tween.tween_property(right_door, "rotation_degrees:y", 0, door_opening_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	is_open = false
	
	await active_tween.finished
	closed.emit()

func toggle(invert_direction := false) -> void:
	if is_open: close()
	else: open(invert_direction)

func get_interact_text() -> String:
	return ("Close" if is_open else "Open") + " Door"

func _on_interaction_ended(invert_direction: bool) -> void:
	toggle(invert_direction)
