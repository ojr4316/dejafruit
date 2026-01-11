extends AnomalyEvent

func perform():
	var special_fruit := world.get_tree().get_first_node_in_group("special_fruit")
	special_fruit.start_dupe()

func cleanup():
	var spawned := world.get_tree().get_first_node_in_group("spawned")
	for s in spawned:
		s.queue_free()
