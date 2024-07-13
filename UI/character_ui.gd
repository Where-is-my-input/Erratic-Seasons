extends Control

@onready var hp = $HBoxContainer/BoxContainer/HP
@onready var lblname = $HBoxContainer/BoxContainer/name

var charType:Global.character = Global.character.CECILIA

# Called when the node enters the scene tree for the first time.
func _ready():
	match charType:
		0:
			lblname.text = "Cecilia"
		1:
			lblname.text = "Geovanna"
		_:
			lblname.text = "Something"
