extends BattleClass

func setSoundtrack():
	SoundManager.PlayClip(battle_soundtrack, "IKnowYourSecret")

func endBattle():
	await get_tree().create_timer(2).timeout
	Global.npcParty.clear()
	get_tree().change_scene_to_file("res://game_scenes/secret_game_clear/secret_game_clear.tscn")
