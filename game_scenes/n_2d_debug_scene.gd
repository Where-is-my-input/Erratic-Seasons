extends Control

@onready var button = $Container/BoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.grab_focus()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


func _on_button_2_pressed():
	Global.npcParty.push_back(preload("res://characters/npc/twin_angels.tscn").instantiate())


func _on_button_3_pressed():
	for c in Global.playerParty:
		c.HP = 1
		c.isDead = false
