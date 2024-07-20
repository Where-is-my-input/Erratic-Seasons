extends Node2D

@export var characterType:Global.character

#Stats
@export var characterName = "Character Name"
@export var maxHP:int = 100
@onready var HP = maxHP
@export var atk = 10
@export var isNPC = true
@export var level = 0
var xp:int = 0
#equipment
#@export var equipment:Array
@export var weapon:Node
@export var armor:Node
@export var sprite:PackedScene

var isDead = false

signal gotHit()
signal died()
signal revived()
signal attack

func _init(lvl = 1):
	#level += lvl
	#scaleStatsToLevel()
	HP = maxHP

#func _ready():
	#HP = maxHP

func scaleStatsToLevel():
	maxHP = (level * 0.25) * maxHP
	atk = (level * 0.08) * atk

func levelUp():
	level += 1
	#scaleStatsToLevel()
	HP = maxHP

func gainXp(value = 0):
	xp += value
	var levelUpThreshold:int = (level * (500)) / ((2 * (level * 0.1)) + 1)
	if xp > levelUpThreshold:
		xp -= levelUpThreshold
		levelUp()
		gainXp()

# Called when the node enters the scene tree for the first time.
#func _ready():
	#HP = maxHP

func getHit(damage = 10):
	HP -= damage
	print(self, " hit for ", damage, " damage - current HP is now ", HP)
	if HP <= 0 && !isDead:
		isDead = true
		if isNPC:
			died.emit()
			#queue_free()#maybe keep the node "alive" so someone could revive it
		else:
			print("Player character dead")
			Global.playerCharacterDied.emit()
	gotHit.emit(HP)

func revive(value = 10):
	HP = value
	isDead = false
	revived.emit()

func equip(equipment):
	if equipment.equipmentType == Global.equipmentType.ARMOR:
		Global.playerInventory.push_back(armor)
		armor = equipment
	else:
		Global.playerInventory.push_back(weapon)
		weapon = equipment
	Global.playerInventory.erase(equipment)

func useItem(item:itemClass):
	match item.type:
		Global.itemType.HEAL:
			heal(item.effectValue)
	Global.playerItems.erase(item)

func heal(value):
	HP += value
	if HP > maxHP:
		HP = maxHP
