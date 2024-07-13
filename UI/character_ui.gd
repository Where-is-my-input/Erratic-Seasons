extends Control

@export var hp:ProgressBar
@export var lblname:Label

@onready var v_box_container = $HBoxContainer/VBoxContainer
@onready var v_box_container_2 = $HBoxContainer/VBoxContainer2


var character:Node2D

signal attack
signal talk
signal inspect
signal flee

signal items
signal equipment

var turnActionAvailable = true

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
	character.connect("died", dead)

func updateUI():
	hp.value = character.HP

func setDisabledAll(value = true):
	setDisabled(v_box_container, value)
	setDisabled(v_box_container_2, value)

func setDisabled(container, value = true):
	for c in container.get_children():
		c.disabled = value

func _on_attack_pressed():
	turnActionAvailable = false
	setDisabledAll()
	attack.emit(character)

func setTurnDisabled():
	setDisabledAll(!turnActionAvailable)

func dead():
	pass #show a skull sprite
