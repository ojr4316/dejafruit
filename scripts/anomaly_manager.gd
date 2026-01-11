# Global AnomalyManager
extends Node

const ANOMALY_CHANCE = 1.0#0.6

var anomalies: Array[AnomalyEvent]
var current_anomaly: AnomalyEvent

var world_ref: World

var has_fruit := false
var anomaly_present := false

func _ready():
	load_anomalies()
	world_ref = get_tree().get_first_node_in_group("world")

func set_fruit(x: bool):
	has_fruit = x
	get_tree().get_first_node_in_group("checkout").enabled = x

func start_random():
	print("NEW CYCLE!")
	
	if current_anomaly != null:
		current_anomaly.cleanup()
		current_anomaly = null
	
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
