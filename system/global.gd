extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS, ALYA, YAEL, ALEXANDRA, RENI, GOBLIN}
enum seasons {SPRING, SUMMER, AUTUMN, WINTER}
enum type {AIR, FIRE, EARTH, WATER}
enum equipmentType {WEAPON, ARMOR}
enum itemType {HEAL}

const RANDOM_MOBS:Array = [preload("res://characters/npc/mobs/goblin.tscn"), preload("res://characters/npc/mobs/red_goblin.tscn"), preload("res://characters/npc/mobs/blue_goblin.tscn")]

var OwScene : PackedScene = preload("res://game_scenes/OverWorld/over_world.tscn")

var playerParty:Array
var npcParty:Array
var currentSeason = seasons.SPRING
var gameOvers:int = 0

var playerInventory:Array
var playerItems:Array
#will be the floor variable
var encountersCounter : int = 0
var encounterStored : Array[int]
var playerLastPos : Vector2 = Vector2.ZERO
var playerMoney : float = 0.0
var isRandomized : bool = false

signal playerCharacterDied

# Called when the node enters the scene tree for the first time.
func _ready():
	playerInventory.push_back(preload("res://equipment/weapon/old_club.tscn").instantiate())
	playerInventory.push_back(preload("res://equipment/weapon/earth_dagger.tscn").instantiate())
	playerItems.push_back(preload("res://equipment/items/small_potion.tscn").instantiate())
	var cc = preload("res://characters/defined/cecilia.tscn").instantiate()
	var geo = preload("res://characters/defined/geovanna.tscn").instantiate()
	
	cc.heal(500)
	geo.heal(500)
	
	playerParty.push_back(cc)
	playerParty.push_back(geo)
	
	changeSeason(randi_range(0,3))

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
	currentSeason += value
	if currentSeason > seasons.WINTER:
		currentSeason -= 4

#Increases everyEncounter
func IncreaseEncCounter() -> void:
	encountersCounter += 1
	
#Useful to use when the player dies
func ResetEncCounter() -> void:
	encountersCounter = 0

#Retrieves a text so it can be used in the labels
func GetCurrentSeason() -> String:
	var textSeason = " ";
	match(currentSeason):
		0:
			textSeason = "Spring"
		1:
			textSeason = "Summer"
		2:
			textSeason = "Autumn"
		3:
			textSeason = "Winter"

	return textSeason
