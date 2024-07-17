extends Control

signal response

@onready var lbl_dialog = $VBoxContainer/HBoxContainer/lblDialog
@onready var btn_op_1 = $VBoxContainer/HBoxContainer2/btnOp1
@onready var btn_op_2 = $VBoxContainer/HBoxContainer2/btnOp2

func setDialogAndOptions(npc = null):
	match npc:
		Global.character.GOBLIN:
			setTexts("The Goblin doesn't look like he can understand you.",
			"English, do you understand?",
			"Oh look, an airplane!")
		_:
			lbl_dialog.text = "The Goblin doesn't look like he can understand you."
			btn_op_1.text = "English, do you understand?"
			btn_op_2.text = "Oh look, an airplane!"

func setTexts(dialog, op1, op2):
	lbl_dialog.text = dialog
	btn_op_1.text = op1
	btn_op_2.text = op2


func _on_btn_op_1_pressed():
	response.emit(true, false)


func _on_btn_op_2_pressed():
	response.emit(false, true)
