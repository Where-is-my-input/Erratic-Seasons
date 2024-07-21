extends Node2D

@export var characterType:Global.character
#BaseStats
@export var baseHP:int
@export var baseAtk:int
@export var baseDef:int
#Stats
@export var characterName = "Character Name"
@onready var maxHP:int = 100
@onready var HP = maxHP
@onready var atk = 10
@onready var def = 10
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
signal attackMissed

#func _init(lvl = 1):
	#atk = baseAtk
	#def = baseDef
	#maxHP = baseHP
	#level += lvl
	#scaleStatsToLevel()
	#HP = maxHP

func _ready():
	atk = baseAtk
	def = baseDef
	maxHP = baseHP
	levelUp()
	HP = maxHP

func scaleStatsToLevel():
	maxHP += (level * 0.025) * baseHP
	atk += (level * 0.008) * baseAtk
	def += (level * 0.008) * baseDef

func levelUp(levels = 1):
	level += levels
	scaleStatsToLevel()
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

func attackMiss():
	attackMissed.emit()

func revive(value = 10):
	heal(value)
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
	if HP == null: return
	HP += value
	if HP > maxHP:
		HP = maxHP
