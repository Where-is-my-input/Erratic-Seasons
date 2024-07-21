extends CollisionShape2D

@onready var color_rect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.size = shape.size
	color_rect.global_position = global_position - Vector2(shape.size.x / 2, shape.size.y / 2)

