extends Node2D

#Reference variables
@onready var roll_button: Button = $UI/MC/VBContainer/RollButton
@onready var dice_anim: AnimatedSprite2D = $PlayerAnim
@onready var dice_stream: AudioStreamPlayer2D = $DiceStream
@onready var max_rerrolLabel: Label = $UI/MC/VBContainer/MaxRerrol
@onready var reroll_button: Button = $UI/MC/VBContainer/RerollButton
@onready var enemy_timer: Timer = $EnemyTimer
@onready var mc: MarginContainer = $UI/MC


#Logic variables
var randomNumber1 = RandomNumberGenerator.new()
var randomNumber2 = RandomNumberGenerator.new()
var firstRoll : int = 0
var secondRoll : int = 0

var loopCounter = 0
var maxLoopAmount = 4
var currentReRoll = 0
var maxReRoll = 1
var isPlayer : bool = false

#visual variables
var enemyDicePos : Vector2 = Vector2(1060, 200)

signal on_player_dice_played(diceNumber : int)
signal on_enemy_dice_played(diceNumber : int)
signal on_dice_finished()

func _ready() -> void:
	call_deferred("McGetFocus")
	SetPlayerReRollLabel()
	CheckEnemy()
	
func McGetFocus() -> void:
	mc.grab_focus()
	
#PlayTheDice -> randomize the playerDice number
func PlayPlayerDice() -> void:
	randomNumber1.randomize()
	firstRoll = randomNumber1.randi_range(1, 6)
	dice_anim.play("RollDice")
	on_player_dice_played.emit(firstRoll)
	SoundManager.PlayClip(dice_stream, SoundManager.SFX_ROLLDICE)

func PlayEnemyDice() -> void:
	randomNumber2.randomize()
	secondRoll = randomNumber2.randi_range(1,6)
	dice_anim.play("RollDice")
	on_enemy_dice_played.emit(secondRoll)
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
	PlayPlayerDice()

func _on_dice_anim_animation_looped() -> void:
	#here the dice loops 4 times, after it finishes its execution
	#the code in the matchLoop is executed
	loopCounter += 1
	match(loopCounter):
		maxLoopAmount:
				dice_anim.stop()
				if(isPlayer):
					dice_anim.frame = firstRoll - 1
				else:
					dice_anim.frame = secondRoll - 1
				loopCounter = 0
				on_dice_finished.emit()

func _on_reroll_button_pressed() -> void:
	#When we press the reroll, the counter goes up, and we check for max rerolls
	currentReRoll += 1
	PlayPlayerDice()
	SetPlayerReRollLabel()
	if(currentReRoll == maxReRoll):
		reroll_button.disabled = true

func _on_enemy_timer_timeout() -> void:
	PlayEnemyDice()

func GetIsPlayer() -> bool : return isPlayer
func GetCurrentReRoll() -> int : return currentReRoll
func GetMaxReRoll() -> int : return maxReRoll
func DestroyDice() -> void:
	queue_free()
