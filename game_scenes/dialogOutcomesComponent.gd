extends Node
@onready var dialog_outcome = $"../tabs/dialogOutcome"

func defineOutCome(player, target, op1, op2):
	match target.characterType:
		Global.character.RENI:
			if op1:
				dialog_outcome.setText("**Stares**")
				player.getHit(1)
			else:
				dialog_outcome.setText("She T poses you back")
				player.getHit(15)
		Global.character.ALEXANDRA:
			if op1:
				dialog_outcome.setText("She ignores you")
			else:
				if randi_range(0,1) == 1:
					dialog_outcome.setText("Nah I'd win")
				else:
					dialog_outcome.setText("If I don't try then I wouldn't get a chance")
					target.heal(10)
		_:
			if op1:
				dialog_outcome.setText("aoisngiasngoiansoginasoign")
				target.getHit()
			else:
				if Global.playerParty.size() < 3:
					dialog_outcome.setText("aoisngiasngoiansoginasoign")
					target.get_parent().remove_child(target)
					Global.playerParty.push_back(target)
					target.isNPC = false
				else:
					dialog_outcome.setText("Nobody seemed to hear you")
	dialog_outcome.visible = true
