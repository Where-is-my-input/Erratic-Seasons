extends Control

@onready var hp = $HBoxContainer/BoxContainer/HP
@onready var lblname = $HBoxContainer/BoxContainer/name

var character:Node2D

signal attack
signal talk
signal inspect
signal flee

signal items
signal equipment

# Called when the node enters the scene tree for the first time.
func _ready():
	match character.characterType:
		0:
			lblname.text = "Cecilia"
		1:
			lblname.text = "Geovanna"
		_:
			lblname.text = "Something"
	hp.max_value = character.maxHP
	if character.HP == null:
		hp.value = character.maxHP
	else:
		hp.value = character.HP
	character.connect("gotHit", updateUI)

func updateUI():
	hp.value = character.HP


func _on_attack_pressed():
	attack.emit(character)
