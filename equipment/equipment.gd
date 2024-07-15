extends Node

@export var equipmentName = "Simple sword"
@export var type:Global.type
@export var atk:int = 1
@export var def:int = 1
@export var level = 1

func _init():
	setStats()

func setStats():
	atk = calculateStat(atk)
	def = calculateStat(def)

func calculateStat(stat = 1):
	return (stat * (level * (level * 0.1))) + 1
