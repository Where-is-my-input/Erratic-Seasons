extends Control

@export var hp:ProgressBar
@export var lblname:Label
@export var weapon:Label
@export var armor:Label
@export var sprite:AnimatedSprite2D
@export var btn_attack:Button
@export var btn_talk:Button

@export var v_box_container:BoxContainer
@export var v_box_container_2:BoxContainer

@export var weapon_Atk:Label
@export var armor_Def:Label

var character:Node2D


signal attack
signal talk
signal inspect
signal flee

signal items
signal equipment

#npc signals
signal attacked
signal talkedTo

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
	character.connect("attackMissed", attackMissed)
	setEquipments(character)
	if character.isDead:
		turnActionAvailable = false
		setDisabledAll(true)
	if !character.isNPC:
		grabFocus()

func attackMissed():
	playAnimation("miss")

func attackAnim():
	playAnimation("attack")

func setCharacter():
	lblname.text = character.characterName
	if !character.isNPC:
		sprite.visible = false
	else:
		if character.sprite != null:
			sprite = character.sprite.instantiate()
			add_child(sprite)

func setEquipments(c):
	if c.weapon != null: 
		weapon.text = c.weapon.equipmentName
		weapon_Atk.text = str(c.weapon.atk)
	if c.armor != null: 
		armor.text = c.armor.equipmentName
		armor_Def.text = str(c.armor.def)

func getHit(value = 10):
	playAnimation()
	updateUI()
	#await get_tree().create_timer(1).timeout

func updateUI():
	hp.value = character.HP
	#hp.value = value

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
	updateUI()
	turnActionAvailable = true
	setTurnDisabled()

func dead():
	playAnimation("death")
	if sprite != null:
		await sprite.get_child(0).animation_finished
	queue_free()

#func _on_flee_pressed() -> void:
	#InstatiateDice()
	#pseudo code - if player dice value is higher than
	#the enemy dice value, we can flee
	#get_tree().change_scene_to_packed(Global.OwScene) 
	
func attackButtonVisible(v):
	if character.isDead: return
	btn_attack.grab_focus()
	btn_attack.visible = v
	
func talkButtonVisible(v):
	if character.isDead: return
	btn_talk.visible = v
	btn_talk.grab_focus()

func _on_btn_attack_pressed():
	attacked.emit(character)

func playAnimation(strAnim = "getHit"):
	if sprite != null: 
		sprite.get_child(0).play(strAnim)
		SoundManager.PlayClip(sprite.get_child(1), "getHit")

func _on_equipmet_pressed():
	equipment.emit(self, character)

func endTurn():
	turnActionAvailable = false
	setTurnDisabled()

func _on_talk_pressed():
	endTurn()
	talk.emit(character)

func _on_btn_talk_pressed():
	talkedTo.emit(self)

func _on_inspect_pressed():
	inspect.emit()

func inspectCharacter():
	setEquipments(character)
	v_box_container.visible = true
	v_box_container_2.visible = true
	match randi_range(0,3):
		0:
			armor.text = "?"
			armor_Def.text = "?"
		1:
			weapon.text = "?"
			weapon_Atk.text = "?"
		2:
			weapon.text = "?"
			armor.text = "?"
			weapon_Atk.text = "?"
			armor_Def.text = "?"

func _on_items_pressed():
	items.emit(self, character)

func grabFocus():
	btn_attack.grab_focus()
