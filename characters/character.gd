extends Node2D

@export var characterType:Global.character

#Stats
@export var maxHP = 100
@onready var HP = maxHP
@export var atk = 10
@export var isNPC = true

signal gotHit()
signal died()

func _init():
	HP = maxHP

# Called when the node enters the scene tree for the first time.
#func _ready():
	#HP = maxHP

func getHit(damage = 10):
	HP -= damage
	if HP <= 0 && isNPC:
		print("Dead")
		queue_free()
	gotHit.emit()
