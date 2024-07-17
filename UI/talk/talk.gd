extends Control

signal option1
signal option2

@onready var lbl_dialog = $VBoxContainer/HBoxContainer/lblDialog
@onready var btn_op_1 = $VBoxContainer/HBoxContainer2/btnOp1
@onready var btn_op_2 = $VBoxContainer/HBoxContainer2/btnOp2

func setDialogAndOptions(npc = null):
	match npc:
		_:#Global.character.GOBLIN
			lbl_dialog.text = "The Goblin doesn't look like he can understand you."
			btn_op_1.text = "English, do you understand?"
			btn_op_2.text = "Oh look, an airplane!"
