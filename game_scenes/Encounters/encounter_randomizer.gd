extends Node2D

@export var encounterToRandom : Array[PackedScene]
@onready var encounterPositions : Array[Marker2D]

var rng = RandomNumberGenerator.new()
var randomValues : Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AddEncounterPos()
	SpawnRandomEncounter()
	print(Global.encountersCounter)
	print(Global.encountersCounter)

func AddEncounterPos() -> void:
	var markersParent := get_tree().get_first_node_in_group("Markers")
	for child in markersParent.get_children():
		encounterPositions.append(child)
	
func SpawnRandomEncounter() -> void:
	var posInt = 0
	#checking if isRandomized is not true
	if(!Global.isRandomized):
		Global.isRandomized = true
		rng.randomize()
		#creating a x amount of random numbers, where x is defined by encounterToRandom Size
		for value in encounterToRandom.size():
			randomValues.append(rng.randi_range(0, encounterToRandom.size()-1))    

		for encounter in encounterToRandom:
			var rValuePicker = randomValues.pick_random()
		#getting a randomValue from the list to instatiate
			var newEncounter = encounterToRandom[rValuePicker].instantiate()
			self.call_deferred("add_child", newEncounter)
			newEncounter.global_position = encounterPositions[posInt].global_position
			posInt += 1
		#adding it to the globalEncounterSaver
			Global.encounterStored.append(rValuePicker)
	else:
		#here if the player came back to the OW, it will load the previous #encounters and not new ones
		for value in Global.encounterStored:
			var newEncounter = encounterToRandom[value].instantiate()
			self.call_deferred("add_child", newEncounter)
			newEncounter.global_position = encounterPositions[posInt].global_position
			posInt += 1
