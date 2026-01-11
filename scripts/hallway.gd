class_name Hallway extends Node3D

@onready var end_door: AutoDoor = $EndAnomalyDoor
@onready var start_door: AutoDoor = $StartAnomalyDoor

@export var destroy_start_door := false
@export var destroy_end_door := false

func _ready():
	if destroy_start_door:
		start_door.queue_free()
	if destroy_end_door:
		end_door.queue_free()
