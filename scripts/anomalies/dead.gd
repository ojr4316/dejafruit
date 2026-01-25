extends AnomalyEvent

func perform():
	print("all dead")
	var npcs := world.get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.die()
		
func cleanup():
	var npcs := world.get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.revive()
