extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"): get_tree().change_scene_to_file("res://UI/main_menu.tscn")
