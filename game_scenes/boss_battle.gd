extends BattleClass

#var airEarthDamage = 0
#var fireWaterDamage = 0

func setSoundtrack():
	SoundManager.PlayClip(battle_soundtrack, "pleaseAnswearMe")

func npcCharacterDied(deadTarget = null):
	for c in Global.npcParty:
		if c.isDead:
			match c.characterType:
				Global.character.ALYA:
					get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition_2.tscn")
				Global.character.YAEL:
					get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition.tscn")

#func attack(attacker, target = null):
	#var dmgDealt = super(attacker, target)
	#match attacker.weapon.type:
		#Global.type.AIR:
			#airEarthDamage += dmgDealt
		#Global.type.EARTH:
			#airEarthDamage += dmgDealt
		#Global.type.FIRE:
			#fireWaterDamage += dmgDealt
		#Global.type.WATER:
			#fireWaterDamage += dmgDealt
	#if airEarthDamage > target.HP:
		#get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition.tscn")
	#elif fireWaterDamage > target.HP:
		#get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition_2.tscn")
