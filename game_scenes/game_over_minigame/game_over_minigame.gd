extends Node2D

@export var difficulty:int = 0
@onready var tmr_revive = $CanvasLayer/tmrRevive
@onready var player = $CanvasLayer/player
@onready var col_track = $CanvasLayer/colTrack


#func _init(dif = 100):
	#difficulty = dif

func _ready():
	difficulty = Global.gameOvers
	z_index = 20
	var index = col_track.get_child_count() - 1
	while index > -1:
		if index >= difficulty:
			col_track.get_child(index).queue_free()
		index -= 1

func _on_tmr_revive_timeout():
	for c in Global.playerParty:
		c.revive()
	queue_free()

func _on_hurtbox_body_entered(body):
	print("Minigame failed")
	#Reset encounters with 0
	Global.ResetEncCounter()
	player.queue_free()

func _on_despawner_body_exited(body):
	#if tmr_revive.is_stopped(): tmr_revive.start(5 + difficulty * 5)
	body.queue_free()

func _on_goal_body_entered(body):
	for c in Global.playerParty:
		c.revive(100)
	queue_free()

func _on_btn_main_menu_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
