extends Control
@onready var label = $Label
@onready var label_2 = $Label2
@onready var btn_destroy = $btnDestroy

#func _input(event):
	#if event.is_action_pressed("ui_accept"):
		#get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_btn_destroy_pressed():
	if Global.mainCharacter == Global.character.CECILIA:
		btn_destroy.visible = false
		label.text = "You always think you are in command"
		await get_tree().create_timer(1).timeout
		label.text = "You always think you are in command."
		await get_tree().create_timer(1).timeout
		label.text = "You always think you are in command.."
		await get_tree().create_timer(1).timeout
		label.text = "You always think you are in command..."
		await get_tree().create_timer(1).timeout
		label_2.text = "I've come this far, I can't let you get away now"
		label_2.visible = true
		await get_tree().create_timer(3).timeout
		startFinalBattle()
	else:
		label.text = "Peace is restored"
		label_2.visible = true
		btn_destroy.visible = false

func startFinalBattle():
	for c in Global.playerParty:
		if c.characterType == Global.character.GEOVANNA:
			Global.playerParty.erase(c)
			Global.npcParty.push_back(c)
			c.isNPC = true
			c.revive(9999)
			c.levelUp(15)
			get_tree().change_scene_to_file("res://game_scenes/secret_final_battle/secret_final_battle.tscn")
