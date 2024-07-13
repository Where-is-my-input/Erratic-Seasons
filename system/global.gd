extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS}

var playerParty:Array

var npcParty:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var cc = preload("res://characters/defined/cecilia.tscn").instantiate()
	var geo = preload("res://characters/defined/geovanna.tscn").instantiate()
	
	playerParty.push_back(cc)
	playerParty.push_back(geo)

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://game_scenes/n_2d_debug_scene.tscn")
