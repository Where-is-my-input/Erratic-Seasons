extends Control

@onready var player_party_container = $CanvasLayer/playerPartyUI/playerPartyContainer
@onready var npc_party_container = $CanvasLayer/npcPartyUI/npcPartyContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in Global.playerParty:
		var charUI = preload("res://UI/character_ui.tscn").instantiate()
		charUI.character = c
		charUI.connect("attack", attack)
		player_party_container.add_child(charUI)
	for c in Global.npcParty:
		var charUI = preload("res://UI/npc_character_ui.tscn").instantiate()
		charUI.character = c
		charUI.connect("attack", attack)
		npc_party_container.add_child(charUI)

func attack(character):
	print("BattleUI attack ", character)
