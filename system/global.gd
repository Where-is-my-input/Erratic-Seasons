extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS, GOBLIN}
enum seasons {SPRING, SUMMER, AUTUMN, WINTER}
enum type {AIR, FIRE, EARTH, WATER}
enum equipmentType {WEAPON, ARMOR}

const RANDOM_MOBS:Array = [preload("res://characters/npc/mobs/goblin.tscn")]

var OwScene : PackedScene = preload("res://game_scenes/OverWorld/over_world.tscn")

var playerParty:Array
var npcParty:Array
var currentSeason = seasons.SPRING
var gameOvers:int = 0

var playerInventory:Array
#will be the floor variable
var encountersCounter :int = 0

signal playerCharacterDied

# Called when the node enters the scene tree for the first time.
func _ready():
	playerInventory.push_back(preload("res://equipment/weapon/old_club.tscn").instantiate())
	playerInventory.push_back(preload("res://equipment/weapon/old_club.tscn").instantiate())
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
		var index = randi_range(0, RANDOM_MOBS.size() - 1)
		var npc = RANDOM_MOBS[index].instantiate()
		npc._init()
		Global.npcParty.push_back(npc)

func changeSeason(value = 1):
	currentSeason += 1
	if currentSeason > seasons.WINTER:
		currentSeason -= 4

#Increases everyEncounter
func IncreaseEncCounter() -> void:
	encountersCounter += 1
	
#Useful to use when the player dies
func ResetEncCounter() -> void:
	encountersCounter = 0
