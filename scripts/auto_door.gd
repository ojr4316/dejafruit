class_name AutoDoor extends Node3D

@onready var left_body: AnimatableBody3D = %LeftBody
@onready var right_body: AnimatableBody3D = %RightBody

var active_tween: Tween = null

func toggle(open: bool) -> void:
	if active_tween:
		active_tween.stop()
	
	active_tween = create_tween()
	
	active_tween.set_parallel()
	
	if open:
		active_tween.tween_property(left_body, "position:x", -1, 1)
		active_tween.tween_property(right_body, "position:x", 2, 1)
	else:
		active_tween.tween_property(left_body, "position:x", 0, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
		active_tween.tween_property(right_body, "position:x", 1, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	
	
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		toggle(true)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		toggle(false)
