extends Node2D

#Reference variables
@onready var roll_button: Button = $UI/MC/VBContainer/RollButton
@onready var dice_anim: AnimatedSprite2D = $PlayerAnim
@onready var dice_stream: AudioStreamPlayer2D = $DiceStream
@onready var max_rerrolLabel: Label = $UI/MC/VBContainer/MaxRerrol
@onready var reroll_button: Button = $UI/MC/VBContainer/RerollButton
@onready var enemy_timer: Timer = $EnemyTimer

#Logic variables
var randomNumber1 = RandomNumberGenerator.new()
var p1Roll : int = 0
var loopCounter = 0
var maxLoopAmount = 4
var currentReRoll = 0
var maxReRoll = 3
var isPlayer : bool = false

#visual variables
var enemyDicePos : Vector2 = Vector2(1060, 200)

signal on_dice_played(diceNumber : int, isPlayerRoll: bool)

func _ready() -> void:
	SetPlayerReRollLabel()
	CheckEnemy()
	
#PlayTheDice -> randomize the number
func PlayTheDice() -> void:
	randomNumber1.randomize()
	p1Roll = randomNumber1.randi_range(1, 6)
	dice_anim.play("RollDice")
	on_dice_played.emit(p1Roll)
	SoundManager.PlayClip(dice_stream, SoundManager.SFX_ROLLDICE)

func SetPlayerReRollLabel() -> void:
	max_rerrolLabel.text = "Rerrol %d/%d" % [currentReRoll, maxReRoll] 

func CheckEnemy() -> void:
	#Here we check if it's enemy or not, if so we change some properties
	if(!isPlayer):
		roll_button.visible = false
		reroll_button.visible = false
		max_rerrolLabel.visible = false
		dice_anim.global_position = enemyDicePos
		enemy_timer.start()

func IsPlayerDice(isOwnerPlayer : bool) -> void:
	isPlayer = isOwnerPlayer

func _on_button_pressed() -> void:
	roll_button.disabled = true
	#enemy_anim.play("EnemyAnim")
	PlayTheDice()

func _on_dice_anim_animation_looped() -> void:
	#here the dice loops 4 times, after it finishes its execution
	#the code in the matchLoop is executed
	loopCounter += 1
	match(loopCounter):
		maxLoopAmount:
				dice_anim.stop()
				dice_anim.frame = p1Roll - 1
				loopCounter = 0

func _on_reroll_button_pressed() -> void:
	#When we press the reroll, the counter goes up, and we check for max rerolls
	currentReRoll += 1
	PlayTheDice()
	SetPlayerReRollLabel()
	if(currentReRoll == maxReRoll):
		reroll_button.disabled = true

func _on_enemy_timer_timeout() -> void:
	PlayTheDice()

func GetIsPlayer() -> bool : return isPlayer
