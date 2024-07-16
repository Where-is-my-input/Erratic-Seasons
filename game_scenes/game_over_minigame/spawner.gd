extends Node2D
@onready var timer = $Timer

@export var movementFrom:Vector2 = Vector2(5,25)
@export var movementTo:Vector2 = Vector2(10,50)

@export var xDrift:int = 0
@export var yDrift:int = 0

const MINIGAME_PROJECTILE = preload("res://game_scenes/game_over_minigame/minigame_projectile.tscn")

func _ready():
	spawn()
	timer.start(randi_range(0, 10 - get_parent().get_parent().difficulty))

func _on_timer_timeout():
	spawn()
	timer.start(randi_range(0, 10 - get_parent().get_parent().difficulty) + 0.1)

func spawn():
	var projectile = MINIGAME_PROJECTILE.instantiate()
	projectile.movement = Vector2(randi_range(movementFrom.x, movementTo.x), randi_range(movementFrom.y, movementTo.y))
	add_child(projectile)
