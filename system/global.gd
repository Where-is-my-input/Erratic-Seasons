extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS, ALYA, YAEL, ALEXANDRA, RENI, GOBLIN, GHOST_WOLF, UNDEAD, REAPER}
enum seasons {SPRING, SUMMER, AUTUMN, WINTER}
enum type {AIR, FIRE, EARTH, WATER}
enum equipmentType {WEAPON, ARMOR}
enum itemType {HEAL}

var mainCharacter:Global.character

const RANDOM_MOBS:Array = [preload("res://characters/npc/mobs/goblin.tscn"), 
preload("res://characters/npc/mobs/red_goblin.tscn"), 
preload("res://characters/npc/mobs/blue_goblin.tscn"),
preload("res://characters/npc/mobs/green_ghost_wolf.tscn"),
preload("res://characters/npc/mobs/purple_ghost_wolf.tscn"),
preload("res://characters/npc/mobs/red_ghost_wolf.tscn"),
preload("res://characters/npc/mobs/old_undead.tscn"),
preload("res://characters/npc/mobs/rotten_undead.tscn"),
preload("res://characters/npc/mobs/undead.tscn"),
preload("res://characters/npc/mobs/reaper.tscn"),
preload("res://characters/npc/mobs/dark_reaper.tscn"),
preload("res://characters/npc/mobs/bloody_reaper.tscn")]

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
var playerMoney : int = 500
var isRandomized : bool = false
var hasFled : bool = false

var iconsDict = {
	"Spring" : preload("res://assets/sprites/seasons/hairymnstr_seasons_spring.svg"),
	"Summer" : preload("res://assets/sprites/seasons/hairymnstr_seasons_summer.svg"),
	"Autumn" : preload("res://assets/sprites/seasons/hairymnstr_seasons_autumn.svg"),
	"Winter" : preload("res://assets/sprites/seasons/hairymnstr_seasons_winter.svg")
}

signal playerCharacterDied

# Called when the node enters the scene tree for the first time.
#func _ready():
	#newGame()

func newGame(ccNewGame = true):
	playerMoney = 500
	for c in playerParty:
		c.queue_free()
	playerParty.clear()
	for c in playerInventory:
		c.queue_free()
	playerInventory.clear()
	playerInventory.push_back(preload("res://equipment/weapon/old_club.tscn").instantiate())
	playerInventory.push_back(preload("res://equipment/weapon/earth_dagger.tscn").instantiate())
	playerItems.push_back(preload("res://equipment/items/small_potion.tscn").instantiate())

	var cc = preload("res://characters/defined/cecilia.tscn").instantiate()
	var geo = preload("res://characters/defined/geovanna.tscn").instantiate()
	
	cc.heal(500)
	geo.heal(500)
	
	cc._ready()
	geo._ready()
	
	playerParty.push_back(cc)
	playerParty.push_back(geo)
	changeSeason(randi_range(0,3))
	ResetEncCounter()
	
	if ccNewGame:
		mainCharacter = character.CECILIA
		cc.levelUp(5)
	else:
		mainCharacter = character.GEOVANNA
		geo.levelUp(5)
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


func _input(event):
	if event.is_action_pressed("reset") && OS.is_debug_build():
		npcParty.clear()
		get_tree().change_scene_to_file("res://game_scenes/n_2d_debug_scene.tscn")

func createRandomNPCParty(partySize = 4):
	npcParty.clear()
	var amount = randi_range(1,partySize)
	for i in amount:
		var index = randi_range(0, RANDOM_MOBS.size() - 1)
		var npc = RANDOM_MOBS[index].instantiate()
		#npc._init()
		npc._ready()
		Global.npcParty.push_back(npc)

func changeSeason(value = 1):
	currentSeason += value
	if currentSeason > seasons.WINTER:
		currentSeason -= 4

#Increases everyEncounter
func IncreaseEncCounter() -> void:
	encountersCounter += 1
	
#Useful to use when the player dies and the game starts
func ResetEncCounter() -> void:
	encountersCounter = 0
	isRandomized = false
	encounterStored.clear()
	playerLastPos = Vector2.ZERO
	hasFled = false

func NextFloor() -> void:
	isRandomized = false
	encounterStored.clear()
	playerLastPos = Vector2.ZERO
	hasFled = false

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

func GetCurrentIconSeason() -> Object:
	var currentIcon
	match(currentSeason):
		0:
			currentIcon = iconsDict["Spring"]
		1:
			currentIcon = iconsDict["Summer"]
		2:
			currentIcon = iconsDict["Autumn"]
		3:
			currentIcon = iconsDict["Winter"]
	return currentIcon
