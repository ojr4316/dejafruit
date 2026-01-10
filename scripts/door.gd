class_name Door extends Interactive

signal opened
signal closed

const DEGREES_OPEN := 120

@onready var body: AnimatableBody3D = $AnimatableBody3D

var is_open := false
var is_moving := false

var active_tween: Tween = null

func open(invert_direction := false) -> void:
	if active_tween: active_tween.stop()
	active_tween = create_tween()
	active_tween.tween_property(body, "rotation_degrees:y", -DEGREES_OPEN if invert_direction else DEGREES_OPEN, 1).set_trans(Tween.TRANS_CUBIC)
	is_moving = true
	is_open = true
	
	await active_tween.finished
	opened.emit()
	is_moving = false


func close() -> void:
	if active_tween: active_tween.stop()
	active_tween = create_tween()
	active_tween.tween_property(body, "rotation_degrees:y", 0, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	is_moving = true
	is_open = false
	
	await active_tween.finished
	closed.emit()
	is_moving = false

func toggle(invert_direction := false) -> void:
	if is_open: close()
	else: open(invert_direction)

func _on_interaction_ended(invert_direction: bool) -> void:
	toggle(invert_direction)

func get_interact_text() -> String:
	return ("Close" if is_open else "Open") + " Door"
