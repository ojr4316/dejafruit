class_name Cashier extends Interactive

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func get_interact_text() -> String:
	return "Checkout"

func _on_interaction_area_interaction_ended(_invert: bool) -> void:
	if AnomalyManager.has_fruit:
		print("PURCHASE")
		audio.play()
		
		AnomalyManager.has_fruit = false
		
