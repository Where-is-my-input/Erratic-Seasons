extends Control
@onready var play = $VBoxContainer/Play
@onready var audio_stream_player = $AudioStreamPlayer

var debugCount = 0
@onready var credits = $credits
@onready var creditsControl = $credits/Credits

func _ready():
	SoundManager.PlayClip(audio_stream_player, "selectGameMode")
	play.grab_focus()
	Global.ResetEncCounter()

func _on_exit_pressed():
	get_tree().quit()

func _input(event):
	if event.get_action_strength("reset"):
		debugCount += 1
		if debugCount > 500:
			get_tree().change_scene_to_file("res://game_scenes/n_2d_debug_scene.tscn")
	else:
		debugCount = 0
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://UI/settings.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://UI/character_select/character_select.tscn")


func _on_credits_pressed():
	#get_tree().change_scene_to_file("res://UI/credits.tscn")
	credits.visible = true
	creditsControl.set_mouse_filter(Control.MOUSE_FILTER_STOP)
