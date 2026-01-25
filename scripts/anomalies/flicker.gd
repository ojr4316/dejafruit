extends AnomalyEvent

func perform():
	var light := world.get_tree().get_first_node_in_group("flicker_light")
	light.start_flicker()
	print("flicker")

func cleanup():
	var light := world.get_tree().get_first_node_in_group("flicker_light")
	light.end_flicker()
