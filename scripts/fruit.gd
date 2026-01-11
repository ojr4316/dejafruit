class_name Fruit extends Node3D

@onready var default: MeshInstance3D = $Default
@onready var rotten: MeshInstance3D = $Rotten

func _ready():
	add_to_group("fruit")
	reset()

func reset():
	default.visible = true
	rotten.visible = false

func rot():
	default.visible = false
	rotten.visible = true
