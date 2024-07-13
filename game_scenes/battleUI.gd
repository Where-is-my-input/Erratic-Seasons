extends Control

@onready var player_party_container = $CanvasLayer/playerPartyUI/playerPartyContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in Global.playerParty:
		var charUI = preload("res://UI/character_ui.tscn").instantiate()
		player_party_container.add_child(charUI)
