extends Node2D

@onready var seasonlabel: Label = $HUD/MC/Seasonlabel
@onready var season_icon: TextureRect = $HUD/SeasonIcon
@onready var over_world_animator: AnimationPlayer = $HUD/OverWorldAnimator
@onready var floor_info: Label = $HUD/MC/FloorInfo
var playerRef : CharacterBody2D
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerRef = get_tree().get_first_node_in_group("Player")
	playerRef.on_encounter_found.connect(OnEncounterFound)
	SetSeasonLabel()
	SetTextureIcon()
	SoundManager.PlayClip(audio_stream_player, "characterBackground")

func SetTextureIcon() -> void:
	var iconSeason = Global.GetCurrentIconSeason()
	season_icon.texture = iconSeason
	season_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH

func SetSeasonLabel() -> void:
	seasonlabel.text = Global.GetCurrentSeason()
	floor_info.text = "Floor: %d" % [Global.encountersCounter]

func OnEncounterFound() -> void:
	over_world_animator.play("HUD_FADEOUT")
