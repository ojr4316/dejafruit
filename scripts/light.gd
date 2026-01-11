class_name Light extends Node3D

@onready var omni: OmniLight3D = $OmniLight3D
var flicker_timer: Timer
@onready var lightbox: CSGBox3D = $CSGBox3D

var flicker_on := false

func start_flicker():
	flicker_timer = Timer.new()
	flicker_timer.one_shot = true
	flicker_timer.autostart = false
	flicker_timer.wait_time = 0.15
	flicker_timer.timeout.connect(flicker)
	add_child(flicker_timer)
	
func end_flicker():
	flicker_timer.queue_free()
	on()

func flicker():
	if flicker_on:
		flicker_on = false
		off()
	else:
		flicker_on = true
		on()
	flicker_timer.wait_time = randf_range(0.1, 0.3)
	flicker_timer.start()

func off():
	lightbox.visible = false
	omni.light_energy = 0.0

func on():
	lightbox.visible = true
	omni.light_energy = 1.0
