extends Control

@onready var spr_cecilia = $sprCecilia
@onready var spr_geovanna = $sprGeovanna
@onready var button = $HBoxContainer/Button
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	spr_cecilia.play("down")
	spr_geovanna.play("down")
	SoundManager.PlayClip(audio_stream_player, "characterBackground")
	button.grab_focus()

func _on_button_pressed():
	Global.newGame()


func _on_button_2_pressed():
	Global.newGame(false)
