extends AnomalyEvent

func perform():
	var light := world.get_tree().get_first_node_in_group("flicker_light")
	light.start_flicker()

func cleanup():
	var light := world.get_tree().get_first_node_in_group("flicker_light")
	light.stop_flicker()
