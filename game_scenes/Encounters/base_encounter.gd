extends Area2D

@export_enum("Battle", "Camp", "Trade", "Boss") var encounterTypes : String
@onready var transition: AnimationPlayer = $Transition
@onready var sprite_2d: Sprite2D = $Sprite2D
var bossesSprites : Array = [
	preload("res://assets/sprites/bosses/overworld/sprite_boss_2.png"),
	preload("res://assets/sprites/bosses/overworld/sprite_boss_1.png"),
	preload("res://assets/sprites/bosses/overworld/sprite_boss_3.png")
]
var encountersScenes = {
	"CampScene" : preload("res://game_scenes/Camp/camp_scene.tscn"),
	"BattleScene" : preload("res://game_scenes/battle.tscn"),
	"TradeScene" : preload("res://game_scenes/Trade/trade_scene.tscn"),
	"BossBattle" : preload("res://game_scenes/boss_battle.tscn")
}
var assignedType : String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CheckTypes(encounterTypes)
	CheckBossSprite()

func CheckTypes(typeToCheck : String) -> void:
	match(typeToCheck):
		"Battle":
			assignedType = "Battle"
		"Camp":
			assignedType = "Camp"
		"Trade":
			assignedType = "Trade"
		"Boss":
			assignedType = "Boss"

func CheckBossSprite() -> void:
	if(assignedType == "Boss"):
		match (Global.encountersCounter):
			0:
				sprite_2d.texture = bossesSprites[0]
			1:
				sprite_2d.texture = bossesSprites[1]
			2:
				sprite_2d.texture = bossesSprites[2]
		

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		transition.play("fadeOut")
		match(assignedType):
			"Battle":
				print("You got attacked by an enemy, engaging battle mode")
				Global.createRandomNPCParty()
			"Camp":
				print("Time for a little rest, nobody is made of iron")
			"Trade":
				print("What do you think about trading that precious coins for my precious items?")
			"Boss":
				Global.npcParty.clear()
				match(Global.encountersCounter):
					0:
						var npc = preload("res://characters/npc/bosses/alexandra.tscn").instantiate()
						npc._ready()
						Global.npcParty.push_back(npc)	
					1:
						var npc = preload("res://characters/npc/bosses/reni.tscn").instantiate()
						npc._ready()
						Global.npcParty.push_back(npc)
					2:
						var npc = preload("res://characters/npc/bosses/alya_phase_1.tscn").instantiate()
						npc._ready()
						Global.npcParty.push_back(npc)
						npc = preload("res://characters/npc/bosses/yael_phase_1.tscn").instantiate()
						npc._ready()
						Global.npcParty.push_back(npc)
func _on_transition_animation_finished(anim_name: StringName) -> void:
	match(assignedType):
		"Battle":
			get_tree().change_scene_to_packed(encountersScenes["BattleScene"])
		"Camp":
			get_tree().change_scene_to_packed(encountersScenes["CampScene"])
		"Trade":
			get_tree().change_scene_to_packed(encountersScenes["TradeScene"])
		"Boss":
			match(Global.encountersCounter):
				2:
					get_tree().change_scene_to_packed(encountersScenes["BossBattle"])
				_:
					get_tree().change_scene_to_packed(encountersScenes["BattleScene"])
			Global.IncreaseEncCounter()
			Global.NextFloor()
