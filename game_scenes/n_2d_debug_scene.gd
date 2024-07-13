extends Control

@onready var button = $Container/BoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


func _on_button_2_pressed():
	Global.npcParty.push_back(preload("res://characters/npc/twin_angels.tscn").instantiate())
