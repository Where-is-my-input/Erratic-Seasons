extends Node2D

var character:Node2D

@export var difficulty:int = 10

#func _init(dif = 100):
	#difficulty = dif

func _ready():
	z_index = 20

func _on_tmr_revive_timeout():
	if character == null: return
	character.revive()
	queue_free()

func _on_hurtbox_body_entered(body):
	print("Minigame failed")
	queue_free()

func _on_despawner_body_exited(body):
	body.queue_free()
