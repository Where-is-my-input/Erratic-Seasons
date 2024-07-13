extends Node2D
@onready var player_party = $playerParty
@onready var npc_party = $NPCParty


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in Global.playerParty:
		player_party.add_child(c)

