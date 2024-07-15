extends CharacterBody2D

@export var movement:Vector2 = Vector2(10,50)

func _physics_process(delta):
	velocity = movement
	velocity += Vector2(get_parent().xDrift, get_parent().yDrift)
	move_and_slide()
