extends Control

@onready var player_party_container = $CanvasLayer/playerPartyUI/playerPartyContainer
@onready var npc_party_container = $CanvasLayer/npcPartyUI/npcPartyContainer
@onready var battle = $".."
@onready var inventory = $tabs/inventory

var playerInAction
var playerUIInAction

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.connect("closeInventory", closeInventory)
	for c in Global.playerParty:
		var charUI = preload("res://UI/character_ui.tscn").instantiate()
		charUI.character = c
		charUI.connect("attack", playerAttacking)
		charUI.connect("equipment", showInventory)
		player_party_container.add_child(charUI)
	for c in Global.npcParty:
		var charUI = preload("res://UI/npc_character_ui.tscn").instantiate()
		charUI.character = c
		#charUI.connect("attack", attack)
		charUI.connect("attacked", playerAttack)
		npc_party_container.add_child(charUI)

func showInventory(charUI, characterEquiping):
	playerInAction = characterEquiping
	playerUIInAction = charUI
	#player_party_container.set_mouse_filter(2)
	disablePlayableCharactersActions()
	inventory.visible = true

func closeInventory(equipment = null):
	if equipment != null: 
		playerUIInAction.endTurn()
		playerInAction.equip(equipment)
		playerUIInAction.setEquipments(playerInAction)
		inventory.loadInventory()
	player_party_container.set_mouse_filter(0)
	inventory.visible = false
	enablePlayerTurn()

func playerAttacking(character):
	playerInAction = character
	enableTargeting()

func enableTargeting(value = true):
	for c in npc_party_container.get_children():
		c.attackButtonVisible(value)

func playerAttack(target):
	enableTargeting(false)
	attack(playerInAction, target)

func attack(character, target = null):
	disablePlayableCharactersActions()
	print("BattleUI attack ", character)
	get_parent().attack(character, target)
	enablePlayerTurn()

func enablePlayerTurn():
	var turnOver = true
	for c in player_party_container.get_children():
		if c.turnActionAvailable: turnOver = false
		c.setTurnDisabled()
	if turnOver:
		print("Turn ended")
		battle.npcTurn()

func endNPCTurn():
	for c in player_party_container.get_children():
		if !c.character.isDead:
			c.turnActionAvailable = true
			c.setDisabledAll(false)
	print("NPC turn ended")

func disablePlayableCharactersActions():
	for c in player_party_container.get_children():
		c.setDisabledAll(true)
