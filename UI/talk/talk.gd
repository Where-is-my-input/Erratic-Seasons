extends Control

signal response

@onready var lbl_dialog = $VBoxContainer/HBoxContainer/lblDialog
@onready var btn_op_1 = $VBoxContainer/HBoxContainer2/btnOp1
@onready var btn_op_2 = $VBoxContainer/HBoxContainer2/btnOp2

func setDialogAndOptions(npc = null):
	match npc.character.characterType:
		Global.character.GOBLIN:
			setTexts("The Goblin doesn't look like he can understand you.",
			"English, do you understand?",
			"Oh look, an airplane!")
		Global.character.ALEXANDRA:
			setTexts("Alexandra looks like she has the greatest will of the world",
			"What if we solve this peacefully?",
			"You know you don't have a chance")
		Global.character.RENI:
			setTexts("This feels awkward",
			"Lets hang out some time",
			"T pose her")
		Global.character.TWIN_ANGELS:
			setTexts("I don't know about this",
			"Ask who is cuter",
			"This is boring, can we please move on?")
		Global.character.ALYA:
			setTexts("She mumbles about how good her fused power feels",
			"Is this getting us closer to the heat death of the universe?",
			"Does this feel better?")
		Global.character.YAEL:
			setTexts("You could never surpass my POWER",
			"Skill issue",
			"I don't have to")
		_:
			lbl_dialog.text = "The Goblin doesn't look like he can understand you."
			btn_op_1.text = "English, do you understand?"
			btn_op_2.text = "Oh look, an airplane!"

func setTexts(dialog, op1, op2):
	lbl_dialog.text = dialog
	btn_op_1.text = op1
	btn_op_2.text = op2

func grabFocus():
	btn_op_1.grab_focus()

func _on_btn_op_1_pressed():
	response.emit(true, false)

func _on_btn_op_2_pressed():
	response.emit(false, true)
