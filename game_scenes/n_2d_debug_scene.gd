extends Control

@onready var button = $Container/BoxContainer/Button
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.PlayClip(audio_stream_player, "characterBackground")
	button.grab_focus()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


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
