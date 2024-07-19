extends Area2D

@export_enum("Battle", "Camp", "Trade") var encounterTypes : String
@onready var transition: AnimationPlayer = $Transition

var encountersScenes = {
	"CampScene" : preload("res://game_scenes/Camp/camp_scene.tscn"),
	"BattleScene" : preload("res://game_scenes/battle.tscn"),
	"TradeScene" : preload("res://game_scenes/Trade/trade_scene.tscn")
}
var assignedType : String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CheckTypes(encounterTypes)

func CheckTypes(typeToCheck : String) -> void:
	match(typeToCheck):
		"Battle":
			assignedType = "Battle"
		"Camp":
			assignedType = "Camp"
		"Trade":
			assignedType = "Trade"

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


func _on_transition_animation_finished(anim_name: StringName) -> void:
	match(assignedType):
		"Battle":
			Global.IncreaseEncCounter()
			get_tree().change_scene_to_packed(encountersScenes["BattleScene"])
		"Camp":
			get_tree().change_scene_to_packed(encountersScenes["CampScene"])
		"Trade":
			get_tree().change_scene_to_packed(encountersScenes["TradeScene"])
