extends Control

@onready var button = $Container/BoxContainer/Button
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.PlayClip(audio_stream_player, "characterBackground")
	button.grab_focus()
	Global.ResetEncCounter()

func _on_button_pressed():
	Global.newGame()
	#get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


func _on_button_2_pressed():
	Global.npcParty.push_back(preload("res://characters/npc/twin_angels.tscn").instantiate())


func _on_button_3_pressed():
	for c in Global.playerParty:
		c.HP = 1
		c.isDead = false


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_button_5_pressed():
	get_tree().change_scene_to_file("res://game_scenes/game_over_minigame/game_over_minigame.tscn")


func _on_button_6_pressed():
	Global.gameOvers += 1


func _on_button_7_pressed():
	var npc = preload("res://characters/npc/bosses/alexandra.tscn").instantiate()
	npc._ready()
	Global.npcParty.push_back(npc)
	get_tree().change_scene_to_file("res://game_scenes/battle.tscn")

func _on_button_8_pressed():
	var npc = preload("res://characters/npc/bosses/reni.tscn").instantiate()
	npc._ready()
	Global.npcParty.push_back(npc)
	get_tree().change_scene_to_file("res://game_scenes/battle.tscn")


func _on_button_9_pressed():
	var npc = preload("res://characters/npc/bosses/alya_phase_1.tscn").instantiate()
	npc._ready()
	Global.npcParty.push_back(npc)
	npc = preload("res://characters/npc/bosses/yael_phase_1.tscn").instantiate()
	npc._ready()
	Global.npcParty.push_back(npc)
	get_tree().change_scene_to_file("res://game_scenes/boss_battle.tscn")


func _on_button_10_pressed():
	for c in Global.playerParty:
		c.levelUp()
