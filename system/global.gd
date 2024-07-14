extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS}
enum seasons {SPRING, SUMMER, AUTUMN, WINTER}

var OwScene : PackedScene = preload("res://game_scenes/OverWorld/over_world.tscn")

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
		npcParty.clear()
		get_tree().change_scene_to_file("res://game_scenes/n_2d_debug_scene.tscn")

func createRandomNPCParty():
	var amount = randi_range(1,6)
	for i in amount:
		Global.npcParty.push_back(preload("res://characters/npc/twin_angels.tscn").instantiate())
