# Global AnomalyManager
extends Node

var anomalies: Array[AnomalyEvent]
var current_anomaly: AnomalyEvent

var world_ref: World

func _ready():
	load_anomalies()
	world_ref = get_tree().get_first_node_in_group("world")
	
func start_random():
	if current_anomaly != null:
		current_anomaly.cleanup()
		current_anomaly = null
	
	if anomalies.size() == 0:
		print("No anomalies left!")
		return
	var choice = anomalies.pick_random()
	current_anomaly = choice
	anomalies.erase(choice)
	choice.world = world_ref
	choice.perform()
	
	
	
func load_anomalies(path="res://scripts/anomalies"):
	
	for file in DirAccess.get_files_at(path):
		if file.ends_with(".gd"):
			var script = load(path + "/" + file)
			if script != null:
				var res = Resource.new()
				res.set_script(script)
				anomalies.append(res)
	print("Loaded ", anomalies.size(), " anomalies!")
