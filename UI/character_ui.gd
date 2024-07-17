extends Control

@export var hp:ProgressBar
@export var lblname:Label
@export var weapon:Label
@export var armor:Label
@export var sprite:AnimatedSprite2D
@export var btn_attack:Button

@export var v_box_container:BoxContainer
@export var v_box_container_2:VBoxContainer


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
	setCharacter()
	hp.max_value = character.maxHP
	if character.HP == null:
		hp.value = character.maxHP
	else:
		hp.value = character.HP
	character.connect("gotHit", getHit)
	character.connect("died", dead)
	character.connect("revived", revive)
	character.connect("attack", attackAnim)
	setEquipments(character)
	if character.isDead:
		turnActionAvailable = false
		setDisabledAll(true)

func attackAnim():
	playAnimation("attack")

func setCharacter():
	match character.characterType:
		0:
			lblname.text = "Cecilia"
			sprite.visible = false
		1:
			lblname.text = "Geovanna"
			sprite.visible = false
		_:
			lblname.text = character.characterName
			if character.sprite != null:
				sprite = character.sprite.instantiate()
				add_child(sprite)

func setEquipments(c):
	if c.weapon != null: weapon.text = c.weapon.equipmentName
	if c.armor != null: armor.text = c.armor.equipmentName

func getHit(value = 10):
	playAnimation()
	updateUI(value)

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
	if character.isDead: return
	btn_attack.visible = v

func _on_btn_attack_pressed():
	attacked.emit(character)

func playAnimation(strAnim = "getHit"):
	if sprite != null: sprite.get_child(0).play(strAnim)

func _on_equipmet_pressed():
	equipment.emit(character)
