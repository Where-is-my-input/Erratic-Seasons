extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS}
enum seasons {SPRING, SUMMER, AUTUMN, WINTER}
enum type {AIR, FIRE, EARTH, WATER}

var OwScene : PackedScene = preload("res://game_scenes/OverWorld/over_world.tscn")

var playerParty:Array
var npcParty:Array
var currentSeason = seasons.SPRING

signal playerCharacterDied

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
	npcParty.clear()
	var amount = randi_range(1,8)
	for i in amount:
		var npc = preload("res://characters/npc/twin_angels.tscn").instantiate()
		npc._init()
		Global.npcParty.push_back(npc)
