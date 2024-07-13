extends Node2D
#@onready var player_party = $playerParty
@onready var npc_party = $NPCParty
#@onready var transition: AnimationPlayer = $Transition
@onready var transition = $battleUI/CanvasLayer/Transition


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
	target.getHit(attacker.atk)
