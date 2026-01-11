class_name Menu extends CanvasLayer

@onready var desc: RichTextLabel = $desc
@onready var label: RichTextLabel = $continue

@export var reveal_rate := 0.25

func _ready():
	desc.visible_ratio = 0
	label.modulate = Color(1, 1, 1, 0)

	var tw := get_tree().create_tween()
	tw.tween_property(label, "modulate", Color.WHITE, 2.5)

func _process(delta: float) -> void:
	if desc.visible_ratio < 1.0:
		desc.visible_ratio += delta * reveal_rate
