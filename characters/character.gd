extends Node2D

@export var characterType:Global.character

#Stats
@export var maxHP = 100
@onready var HP = maxHP
@export var atk = 10
@export var isNPC = true

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
	if HP <= 0:
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
