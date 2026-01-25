extends AnomalyEvent

func perform():
	print("all stare")
	var npcs := world.get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.look_at_player = true
		
func cleanup():
	var npcs := world.get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.reset_look_at_player()
