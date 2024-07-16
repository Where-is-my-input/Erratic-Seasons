extends Node2D
#@onready var player_party = $playerParty
@onready var npc_party = $NPCParty
#@onready var transition: AnimationPlayer = $Transition
@onready var transition = $battleUI/CanvasLayer/Transition
@onready var battle_ui = $battleUI
@onready var battle_soundtrack = $battleSoundtrack

var gameOverMinigame = preload("res://game_scenes/game_over_minigame/game_over_minigame.tscn")

var npcPartyCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setSoundtrack()
	Global.connect("playerCharacterDied", playerCharacterDied)
	transition.play("fadeIn")
	#for c in Global.playerParty:
		#player_party.add_child(c)
	for c in Global.npcParty:
		npcPartyCount += 1
		c.connect("died", npcCharacterDied)
		npc_party.add_child(c)

func setSoundtrack():
	match Global.currentSeason:
		Global.seasons.WINTER:
			SoundManager.PlayClip(battle_soundtrack, "snowSleds")
		Global.seasons.SUMMER:
			SoundManager.PlayClip(battle_soundtrack, "themePark")
		Global.seasons.AUTUMN:
			SoundManager.PlayClip(battle_soundtrack, "michaelHouse")
		Global.seasons.SPRING:
			SoundManager.PlayClip(battle_soundtrack, "snowBall")

func npcCharacterDied():
	npcPartyCount -= 1
	if npcPartyCount <= 0:
		endBattle()

func attack(attacker, target = null):
	print("Battle scene attack called")
	var attackTarget = target if target != null else npc_party.get_child(randi_range(0, npc_party.get_child_count() - 1))
	if target == null: return
	attackTarget.getHit(getDamageDealt(attacker.atk, attacker.weapon, attackTarget.armor))

func getDamageDealt(atk, attackerEquip, targetEquip):
	var attack:int = atk
	if attackerEquip != null:
		attack += attackerEquip.atk * 1.5 if attackerEquip.type == Global.currentSeason else attackerEquip.atk
	var defense:int = 0
	if targetEquip != null:
		defense = targetEquip.def * 1.5 if targetEquip.type == Global.currentSeason else targetEquip.def
	var damageDealt:int = attack - (defense * 0.1)
	print("Damage dealt: ", damageDealt, " Attack ", attack, " defense ", defense)
	return damageDealt if damageDealt > 0 else 1
#I wanted to make an equipment array but man this code looks like shit
#func getDamageDealt(attackerEquip, targetEquip):
	#var damageDealt = 0
	#for equip in attackerEquip:
		#var equipDamage:int = 0
		#if equip.atk == 0: continue
			##damageDealt += equip.atk
		#if targetEquip.size() > 0:
			#for e in targetEquip:
				#if e.def == 0: continue
				#if equip.type == e.type:
					#equipDamage += equip.atk * 0.7
				#equipDamage -= (e.def * 0.1) + 1
		#else:
			#equipDamage = equip.atk
		#damageDealt += equipDamage
	#return damageDealt if damageDealt > 0 else 0

func npcTurn():
	var battleOver = true
	for c in npc_party.get_children():
		if c.isDead: continue
		await get_tree().create_timer(0.3).timeout
		npcAttack(c)
		battleOver = false
	battle_ui.endNPCTurn()

func endBattle():
	print("Battle ended")
	Global.npcParty.clear()
	get_tree().change_scene_to_file("res://game_scenes/OverWorld/over_world.tscn")
	

func npcAttack(attacker):
	var targetId = randi_range(0, Global.playerParty.size() - 1)
	var target = Global.playerParty[targetId]
	while target.isDead:
		if !checkPlayerPartyAlive(): return
		target = getNextAlivePartyMember(targetId)
	#target.getHit(attacker.atk)
	attacker.attack.emit()
	target.getHit(getDamageDealt(attacker.atk, attacker.weapon, target.armor))

func getNextAlivePartyMember(targetId = 0):
	targetId += 1
	if targetId >= Global.playerParty.size():
		targetId = 0
	return Global.playerParty[targetId]

func checkPlayerPartyAlive():
	for c in Global.playerParty:
		if c.HP > 0: return true
	return false

func playerCharacterDied():
	if checkPlayerPartyAlive(): return
	print("Play game over minigame")
	await get_tree().create_timer(2).timeout
	deathMinigame()

func deathMinigame():
	Global.gameOvers += 1
	var minigame = gameOverMinigame.instantiate()
	add_child(minigame)
	
