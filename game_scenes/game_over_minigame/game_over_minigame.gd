extends Node2D

var character:Node2D

func _on_tmr_revive_timeout():
	character.revive()
	queue_free()
