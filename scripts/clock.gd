class_name Clock extends Node3D

const OPENING := 12
const CLOSING := 20

@onready var hours_hand: Marker3D = %Hours
@onready var minutes_hand: Marker3D = %Minutes

@export var do_clock_anomaly := false

var counter := 0.0
func _physics_process(delta: float) -> void:
	
	if not do_clock_anomaly: return
	
	counter -= delta * 10
	set_time_in_minutes(counter)

func set_time_in_minutes(minutes: float) -> void:
	hours_hand.rotation.z = (minutes / -720) * 2 * PI
	minutes_hand.rotation.z = (minutes / -60) * 2 * PI

func set_percent_open_to_close(percent: float) -> void:
	set_time_in_minutes(((CLOSING - OPENING) * percent + OPENING) * 60)
