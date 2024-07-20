extends Control

@onready var texture_rect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.currentSeason:
		Global.seasons.SUMMER:
			texture_rect.scale = Vector2(0.5,0.5)
			texture_rect.texture = preload("res://assets/backgrounds/summer/Summer5.png")
		Global.seasons.AUTUMN:
			#texture_rect.scale = Vector2(0.5,0.5)
			texture_rect.texture = preload("res://assets/backgrounds/background-autumn.png")
		Global.seasons.WINTER:
			texture_rect.scale = Vector2(0.6,0.6)
			texture_rect.texture = preload("res://assets/backgrounds/winter/PNG/BG_01/BG_01.png")

