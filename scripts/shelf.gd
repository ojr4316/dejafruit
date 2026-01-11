extends Node3D

@onready var default: MeshInstance3D = $default
@onready var empty: Node3D = $empty

func _ready():
	add_to_group("shelf")
	init()
	
func init():
	default.visible = true
	empty.visible = false

func empty_shelf():
	default.visible = false
	empty.visible = true
