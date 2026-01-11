# Global AnomalyManager
extends Node

const ANOMALY_CHANCE = 1.0#0.6

var anomalies: Array[AnomalyEvent]
var current_anomaly: AnomalyEvent

var world_ref: World

var has_fruit := false
var did_purchase := false
var anomaly_present := false

var progress := 0

func _ready():
	load_anomalies()
	world_ref = get_tree().get_first_node_in_group("world")

func set_fruit(x: bool):
	has_fruit = x
	get_tree().get_first_node_in_group("checkout").enabled = x

func start_random():
	print("NEW CYCLE!")
	
	## If no anomaly, buy. If anomaly, leave
	
	# Evaluate last
	if (not anomaly_present and not did_purchase) or (did_purchase and anomaly_present):
		progress = 0
		print("MISSED! reset")
		get_tree().get_first_node_in_group("clock").set_percent_open_to_close(0)
	else:
		progress+=1
		get_tree().get_first_node_in_group("clock").set_percent_open_to_close(progress/8.0)

	# Reset world
	if current_anomaly != null:
		current_anomaly.cleanup()
		current_anomaly = null
	world_ref.reset()
	get_tree().get_first_node_in_group("checkout").enabled = false
	did_purchase = false
	has_fruit = false
	
	# New anomaly (or not)
	if anomalies.size() == 0:
		print("No anomalies left!")
		return
		
	if randf() < ANOMALY_CHANCE:
		anomaly_present = true
		var choice = anomalies.pick_random()
		print(choice)
		current_anomaly = choice
		anomalies.erase(choice)
		choice.world = world_ref
		choice.perform()
	
	else: # No anomaly
		anomaly_present = false
		print("none!")
	
	
func load_anomalies(path="res://scripts/anomalies"):
	
	for file in DirAccess.get_files_at(path):
		if file.ends_with(".gd"):
			var script = load(path + "/" + file)
			if script != null:
				var res = Resource.new()
				res.set_script(script)
				anomalies.append(res)
	print("Loaded ", anomalies.size(), " anomalies!")
