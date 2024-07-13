extends Node2D

@onready var transition: AnimationPlayer = $Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fadeIn")
