class_name LoopTomato extends Interactive

var pickup := false

func get_interact_text() -> String:
	return "Place Tomato" if pickup else "Pickup Tomato"

func _on_interaction_area_interaction_ended(invert: bool) -> void:
	if pickup:
		visible = true
		pickup = false
	else:
		visible = false
		pickup = true
		
