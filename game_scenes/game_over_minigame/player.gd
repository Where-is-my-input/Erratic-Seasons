extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var yDirection = Input.get_axis("up", "down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0#move_toward(velocity.x, 0, SPEED)
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = 0#move_toward(velocity.x, 0, SPEED)

	move_and_slide()
