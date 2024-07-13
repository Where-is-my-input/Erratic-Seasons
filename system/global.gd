extends Node

enum character {CECILIA, GEOVANNA, TWIN_ANGELS}

var playerParty:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var cc = preload("res://characters/defined/cecilia.tscn").instantiate()
	var geo = preload("res://characters/defined/geovanna.tscn").instantiate()
	
	playerParty.push_back(cc)
	playerParty.push_back(geo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
