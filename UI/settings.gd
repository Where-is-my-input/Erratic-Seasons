extends Control

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("SFX")
var soundtrack_bus = AudioServer.get_bus_index("soundtrack")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	AudioServer.set_bus_mute(master_bus, false)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(soundtrack_bus, value)
	AudioServer.set_bus_mute(soundtrack_bus, false)
	if value == -30:
		AudioServer.set_bus_mute(soundtrack_bus, true)

func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)
	AudioServer.set_bus_mute(sfx_bus, false)
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
