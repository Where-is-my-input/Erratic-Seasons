extends Node
@onready var dialog_outcome = $"../tabs/dialogOutcome"

func defineOutCome(player, target, op1, op2):
	match target.characterType:
		_:
			if op1:
				dialog_outcome.setText("aoisngiasngoiansoginasoign")
	dialog_outcome.visible = true
