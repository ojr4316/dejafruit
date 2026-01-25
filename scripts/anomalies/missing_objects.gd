extends AnomalyEvent

func perform():
	print("missing things")
	var missing = world.get_tree().get_nodes_in_group("missing2")
	for m in missing:
		m.visible = false
		
func cleanup():
	var missing = world.get_tree().get_nodes_in_group("missing2")
	for m in missing:
		m.visible = true
