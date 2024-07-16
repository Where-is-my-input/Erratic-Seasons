extends Node2D

@export var difficulty:int = 0
@onready var tmr_revive = $CanvasLayer/tmrRevive


#func _init(dif = 100):
	#difficulty = dif

func _ready():
	difficulty = Global.gameOvers
	z_index = 20

func _on_tmr_revive_timeout():
	for c in Global.playerParty:
		c.revive()
	queue_free()

func _on_hurtbox_body_entered(body):
	print("Minigame failed")
	#Reset encounters with 0
	Global.ResetEncCounter()
	queue_free()

func _on_despawner_body_exited(body):
	#if tmr_revive.is_stopped(): tmr_revive.start(5 + difficulty * 5)
	body.queue_free()

func _on_goal_body_entered(body):
	for c in Global.playerParty:
		c.revive()
	queue_free()
