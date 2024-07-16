extends Control

@export var hp:ProgressBar
@export var lblname:Label
@export var weapon:Label
@export var armor:Label
@onready var btn_attack = $HBoxContainer/btnAttack

@onready var v_box_container = $HBoxContainer/VBoxContainer
@onready var v_box_container_2 = $HBoxContainer/VBoxContainer2


var character:Node2D

signal attack
signal attacked
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
	character.connect("revived", revive)
	setEquipments(character)
	if character.isDead:
		turnActionAvailable = false
		setDisabledAll(true)

func setEquipments(c):
	if c.weapon != null: weapon.text = c.weapon.equipmentName
	if c.armor != null: armor.text = c.armor.equipmentName

func updateUI(value = 10):
	#hp.value = character.HP
	hp.value = value

func setDisabledAll(value = true):
	setDisabled(v_box_container, value)
	setDisabled(v_box_container_2, value)

func setDisabled(container, value = true):
	for c in container.get_children():
		c.disabled = value

func _on_attack_pressed():
	if !turnActionAvailable: return
	turnActionAvailable = false
	setDisabledAll()
	attack.emit(character)

func setTurnDisabled():
	if !character.isDead:
		setDisabledAll(!turnActionAvailable)

func revive():
	print("UI revive ", character.HP)
	updateUI(character.HP)
	turnActionAvailable = true
	setTurnDisabled()

func dead():
	pass #show a skull sprite

func _on_flee_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)

func attackButtonVisible(v):
	btn_attack.visible = v

func _on_btn_attack_pressed():
	attacked.emit(character)
