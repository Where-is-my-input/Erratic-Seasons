extends Node
@onready var dialog_outcome = $"../tabs/dialogOutcome"
@onready var battle = $"../.."

func defineOutCome(player, target, op1, op2, targetUI = null):
	match target.characterType:
		Global.character.RENI:
			if op1:
				dialog_outcome.setText("**Stares**")
				player.getHit(1)
			else:
				dialog_outcome.setText("She T poses you back")
				player.getHit(15)
		Global.character.ALYA:
			if op1:
				dialog_outcome.setText("Perhaps, but it isn't something that concerns me.")
				player.getHit(1)
			else:
				dialog_outcome.setText("You are the next one to die.")
				target.heal(25)
		Global.character.YAEL:
			if op1:
				dialog_outcome.setText("UUUUUUUUUUH SHUT UP YOU SCRUB")
				target.getHit(randi_range(1,100))
			else:
				dialog_outcome.setText("Then die!")
		Global.character.TWIN_ANGELS:
			if op1:
				dialog_outcome.setText("We are equally cute")
				player.heal(15)
			else:
				if randi_range(0,8) == 8:
					dialog_outcome.setText("Sure")
					if randi_range(0,1) == 1:
						get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition_2.tscn")
					else:
						get_tree().change_scene_to_file("res://UI/final_boss/final_boss_transition.tscn")
				else:
					dialog_outcome.setText("You have 1 in 8 chance to win")
		Global.character.ALEXANDRA:
			if op1:
				dialog_outcome.setText("She ignores you")
			else:
				if randi_range(0,1) == 1:
					dialog_outcome.setText("Nah I'd win")
				else:
					dialog_outcome.setText("If I don't try then I wouldn't have a chance")
					target.heal(10)
		Global.character.GOBLIN:
			if op1:
				dialog_outcome.setText("aoisngiasngoiansoginasoign")
				target.getHit()
			else:
				if Global.playerParty.size() < 3:
					dialog_outcome.setText("aoisngiasngoiansoginasoign")
					target.get_parent().remove_child(target)
					Global.playerParty.push_back(target)
					target.isNPC = false
					target.sprite = null
					battle.npcCharacterDied()
					targetUI.dead()
				else:
					dialog_outcome.setText("Nobody seemed to hear you")
		_:
			if op1:
				dialog_outcome.setText("...")
				target.getHit(randi_range(1,100))
			else:
				dialog_outcome.setText("What?!")
	dialog_outcome.visible = true
