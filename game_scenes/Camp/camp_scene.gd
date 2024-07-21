extends Node2D

@onready var transition: AnimationPlayer = $CampUI/Transition
@onready var season_inf: Label = $CampUI/MC/SeasonInf
@onready var sleep_animation: AnimationPlayer = $SleepAnimation
@onready var sleep_bt: Button = $CampUI/MC/HBoxContainer/SleepBT
@onready var season_icon: TextureRect = $CampUI/SeasonIcon
@onready var party = $CampUI/party
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetSeasonLabel()
	transition.play("fadeIn")
	SetTextureIcon()
	for c in Global.playerParty:
		var charUI = preload("res://UI/character_ui.tscn").instantiate()
		charUI.character = c
		charUI.hideButtons()
		party.add_child(charUI)
	SoundManager.PlayClip(audio_stream_player, "characterBackground")
	
func SetTextureIcon() -> void:
	var iconSeason = Global.GetCurrentIconSeason()
	season_icon.texture = iconSeason
	season_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	
func _on_gb_bt_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)

func HealPlayer() -> void:
	for c in Global.playerParty:
		c.revive(500)
	#well, it's gonna heal the player
	
func SetSeasonLabel() -> void:
	season_inf.text = Global.GetCurrentSeason()
	
func ChangeSeason() -> void:
	Global.changeSeason()

func _on_sleep_bt_pressed():
	sleep_bt.disabled = true
	Global.changeSeason()
	SetTextureIcon()
	HealPlayer()
	for c in party.get_children():
		c.updateUI()
	sleep_animation.play("SleepAnimation")


func _on_sleep_animation_animation_finished(anim_name: StringName) -> void:
	SetSeasonLabel()
