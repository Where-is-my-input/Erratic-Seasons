extends CharacterBody2D

var playerAxis = Vector2.ZERO as Vector2
var playerSpeed = 200 as float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	MovePlayer(delta)

func MovePlayer(delta : float) -> void:
	playerAxis = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down"),
		)
	velocity = playerAxis * playerSpeed
	move_and_slide()
