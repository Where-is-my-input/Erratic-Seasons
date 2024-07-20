extends Control
@onready var play = $VBoxContainer/Play
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	SoundManager.PlayClip(audio_stream_player, "characterBackground")
	play.grab_focus()
	Global.ResetEncCounter()

func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://UI/settings.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://UI/credits.tscn")
