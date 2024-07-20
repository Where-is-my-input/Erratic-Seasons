extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
var playerAxis = Vector2.ZERO as Vector2
var playerSpeed = 200 as float
var _stopped = false as bool
var spawnPos : Vector2 = Vector2(404,296)
var xOffset : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Global.playerLastPos
	if(global_position == Vector2.ZERO):
		global_position = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	MovePlayer(delta)

func MovePlayer(delta : float) -> void:
	playerAxis = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down"),
		)
	if(!_stopped):
		velocity = playerAxis * playerSpeed
		move_and_slide()

func _on_feet_area_area_entered(area: Area2D) -> void:
	_stopped = true
	
	global_position = area.global_position
	Global.playerLastPos = Vector2(global_position.x + xOffset, global_position.y)
