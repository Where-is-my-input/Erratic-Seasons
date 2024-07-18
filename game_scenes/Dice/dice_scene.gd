extends Node2D

#Reference variables
@onready var roll_button: Button = $UI/MC/VBContainer/RollButton
@onready var dice_anim: AnimatedSprite2D = $PlayerAnim
@onready var dice_stream: AudioStreamPlayer2D = $DiceStream
@onready var enemy_anim: AnimatedSprite2D = $EnemyAnim
@onready var winner_label: Label = $UI/WinnerLabel

#Logic variables
var randomNumber1 = RandomNumberGenerator.new()
var randomNumber2 = RandomNumberGenerator.new()
var p1Roll : int = 0
var pcRoll : int = 0
var loopCounter = 0
var maxLoopAmount = 4

#PlayTheDice -> randomize the number
func PlayTheDice() -> void:
	randomNumber1.randomize()
	randomNumber2.randomize()
	p1Roll = randomNumber1.randi_range(1, 6)
	pcRoll = randomNumber2.randi_range(1, 6)

func CheckRolls() -> void:
	#Here we will do the code that we need
	#the way that is here is for visual debug reasons
	if p1Roll > pcRoll:
		winner_label.text = "Player Wins"
	else:
		winner_label.text = "Computer Wins"

func _on_button_pressed() -> void:
	roll_button.disabled = true
	dice_anim.play("RollDice")
	enemy_anim.play("EnemyAnim")
	PlayTheDice()
	SoundManager.PlayClip(dice_stream, SoundManager.SFX_ROLLDICE)

func _on_dice_anim_animation_looped() -> void:
	#here the dice loops 4 times, after it finishes its execution
	#the code in the matchLoop is executed
	loopCounter += 1
	match(loopCounter):
		maxLoopAmount:
				dice_anim.stop()
				dice_anim.frame = p1Roll - 1
				enemy_anim.stop()
				enemy_anim.frame = pcRoll - 1
				CheckRolls()
