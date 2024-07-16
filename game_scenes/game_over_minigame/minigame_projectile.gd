extends CharacterBody2D

@export var movement:Vector2 = Vector2(10,50)

func _physics_process(delta):
	velocity = movement
	velocity += Vector2(get_parent().xDrift, get_parent().yDrift)
	move_and_slide()


func _on_deflect_body_entered(body):
	var newX = randi_range(0,1)
	var newY = randi_range(0,1)
	newX = newX if newX == 1 else -1
	newY = newY if newY == 1 else -1
	movement *= Vector2(newX, newY)
