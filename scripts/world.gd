class_name World extends Node
# Given to anomalies to modify/add/subtract

@onready var clock: Clock = $Clock

func _ready() -> void:
	clock.set_percent_open_to_close(0.5)
