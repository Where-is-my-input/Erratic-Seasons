extends Control

func _on_timer_timeout():
	Global.npcParty.clear()
	var npc = preload("res://characters/npc/bosses/Yael.tscn").instantiate()
	npc._ready()
	Global.npcParty.push_back(npc)
	get_tree().change_scene_to_file("res://game_scenes/final_boss/final_boss_battle.tscn")
