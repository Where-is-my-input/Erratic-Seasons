extends Node2D

@export var characterType:Global.character

#Stats
@export var maxHP = 100
@onready var HP = maxHP
@export var atk = 10

signal gotHit()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(HP)
	HP = maxHP
