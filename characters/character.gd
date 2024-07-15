extends Node2D

@export var characterType:Global.character

#Stats
@export var maxHP = 100
@onready var HP = maxHP
@export var atk = 10
@export var isNPC = true
@export var level = 1
var xp = 0
#equipment
#@export var equipment:Array
@export var weapon:Node
@export var armor:Node

var isDead = false

signal gotHit()
signal died()
signal revived()

func _init():
	HP = maxHP

# Called when the node enters the scene tree for the first time.
#func _ready():
	#HP = maxHP

func getHit(damage = 10):
	HP -= damage
	print(self, " hit for ", damage, " damage - current HP is now ", HP)
	if HP <= 0 && !isDead:
		isDead = true
		if isNPC:
			print("Dead")
			queue_free()#maybe keep the node "alive" so someone could revive it
		else:
			print("Death minigame")
			Global.deathMinigame.emit(self)
	gotHit.emit(HP)

func revive(value = 10):
	HP = value
	isDead = false
	revived.emit()
