extends Node2D

@onready var transition: AnimationPlayer = $CampUI/Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fadeIn")

func _on_gb_bt_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)

func HealPlayer() -> void:
	pass
	#well, it's gonna heal the player
	
func ChangeSeason() -> void:
	pass
	#gonna change the game actual season
