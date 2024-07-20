extends BattleClass

func setSoundtrack():
	SoundManager.PlayClip(battle_soundtrack, "pleaseAnswearMe")

func endBattle():
	print("Game Over")
	await get_tree().create_timer(2).timeout
	Global.npcParty.clear()
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")
	
