extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
var playerAxis = Vector2.ZERO as Vector2
var playerSpeed = 200 as float
var _stopped = false as bool
var spawnPos : Vector2 = Vector2(395,350)
var xOffset : float = 100
@onready var spr_cecilia = $sprCecilia
@onready var spr_geovanna = $sprGeovanna

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Global.playerLastPos
	if(global_position == Vector2.ZERO):
		global_position = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	MovePlayer(delta)

func MovePlayer(delta : float) -> void:
	var dirX = Input.get_axis("left","right")
	var dirY = Input.get_axis("up", "down")
	playerAxis = Vector2(
		dirX,
		dirY
		)
	if(!_stopped):
		if playerAxis.x == 1:
			setAnimation("right")
		elif playerAxis.x == -1:
			setAnimation("left")
		elif playerAxis.y == -1:
			setAnimation("up")
		elif playerAxis.y == 1:
			setAnimation("down")
		else:
			stopAnimation()
		velocity = playerAxis * playerSpeed
		move_and_slide()
func setAnimation(anim):
	spr_cecilia.play(anim)
	spr_geovanna.play(anim)

func stopAnimation():
	spr_cecilia.pause()
	spr_geovanna.pause()

func _on_feet_area_area_entered(area: Area2D) -> void:
	_stopped = true
	
	global_position = area.global_position
	Global.playerLastPos = Vector2(global_position.x + xOffset, global_position.y)
