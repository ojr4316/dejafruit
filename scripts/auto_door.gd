class_name AutoDoor extends Node3D

@onready var left_body: AnimatableBody3D = %LeftBody
@onready var right_body: AnimatableBody3D = %RightBody

@onready var slide_closed: AudioStreamPlayer3D = $SlideClosed
@onready var slide_open: AudioStreamPlayer3D = $SlideOpen

var active_tween: Tween = null

@export var use_duration := 1.8

var both_x: Vector2:
	get:
		return Vector2(left_body.position.x, right_body.position.x)
	set(value):
		if active_tween: active_tween.stop()
		left_body.position.x = value.x
		right_body.position.x = value.y

func toggle(open: bool) -> void:
	if active_tween:
		active_tween.stop()
	
	active_tween = create_tween()
	
	active_tween.set_parallel()
	
	if open:
		slide_open.play()
		active_tween.tween_property(left_body, "position:x", -1, use_duration)
		active_tween.tween_property(right_body, "position:x", 2, use_duration)
	else:
		slide_closed.play()
		active_tween.tween_property(left_body, "position:x", 0, use_duration-0.2).set_ease(Tween.EASE_IN)
		active_tween.tween_property(right_body, "position:x", 1, use_duration-0.2).set_ease(Tween.EASE_IN)


	
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		toggle(true)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		toggle(false)
