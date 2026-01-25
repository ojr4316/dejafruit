extends AnomalyEvent

func perform():
	print("missing peeps")
	var missing = world.get_tree().get_nodes_in_group("missing")
	for m in missing:
		m.visible = false
		
func cleanup():
	var missing = world.get_tree().get_nodes_in_group("missing")
	for m in missing:
		m.visible = true
