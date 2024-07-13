extends Node2D

@onready var transition: AnimationPlayer = $Transition

func _ready() -> void:
	transition.play("fadeIn")
