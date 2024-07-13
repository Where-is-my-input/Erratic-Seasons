extends Node2D
#@onready var player_party = $playerParty
@onready var npc_party = $NPCParty
#@onready var transition: AnimationPlayer = $Transition
@onready var transition = $battleUI/CanvasLayer/Transition
@onready var battle_ui = $battleUI


# Called when the node enters the scene tree for the first time.
func _ready():
	transition.play("fadeIn")
	#for c in Global.playerParty:
		#player_party.add_child(c)
	for c in Global.npcParty:
		npc_party.add_child(c)

func attack(attacker):
	print("Battle scene attack called")
	var targetId = randi_range(0, npc_party.get_child_count() - 1)
	var target = npc_party.get_child(targetId)
	if target == null: return
	target.getHit(attacker.atk)

func npcTurn():
	var battleOver = true
	for c in npc_party.get_children():
		npcAttack(c)
		battleOver = false
	if battleOver:
		print("Battle ended")
		Global.npcParty.clear()
		get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")
	battle_ui.endNPCTurn()

func npcAttack(attacker):
	var targetId = randi_range(0, Global.playerParty.size() - 1)
	var target = Global.playerParty[targetId]
	print(target)
	target.getHit(attacker.atk)
