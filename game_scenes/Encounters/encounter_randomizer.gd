extends Node2D

@export var encounterToRandom : Array[PackedScene]

@onready var encounterPositions : Array[Marker2D]

var rng = RandomNumberGenerator.new()
var randomValue := 0.0 as float
var posArray : Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AddEncounterPos()
	SpawnRandomEncounter()

func AddEncounterPos() -> void:
	var markersParent := get_tree().get_first_node_in_group("Markers")
	for child in markersParent.get_children():
		encounterPositions.append(child)
	
func SpawnRandomEncounter() -> void:
	var posInt = 0
	for encounter in encounterToRandom:
		rng.randomize()
		randomValue = rng.randi_range(0, encounterToRandom.size()-1)
		var newEncounter = encounterToRandom[randomValue].instantiate()
		#newEncounter.global_position = posArray[posInt].global_position
		newEncounter.global_position = encounterPositions[posInt].global_position
		get_tree().root.call_deferred("add_child", newEncounter)
		posInt += 1
