extends AnomalyEvent

func perform():
	print("faceless")
	var npc := world.get_tree().get_first_node_in_group("faceless")
	npc.disable_face()
		
func cleanup():
	var npc := world.get_tree().get_first_node_in_group("faceless")
	npc.enable_face()
