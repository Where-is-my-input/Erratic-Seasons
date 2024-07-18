extends Node2D

#Reference variables
@onready var roll_button: Button = $UI/MC/VBContainer/RollButton
@onready var dice_anim: AnimatedSprite2D = $PlayerAnim
@onready var dice_stream: AudioStreamPlayer2D = $DiceStream
@onready var max_rerrolLabel: Label = $UI/MC/MaxRerrol
@onready var reroll_button: Button = $UI/MC/VBContainer/RerollButton
@onready var enemy_timer: Timer = $EnemyTimer
@export var isPlayer : bool = false

#Logic variables
var randomNumber1 = RandomNumberGenerator.new()
var p1Roll : int = 0
var loopCounter = 0
var maxLoopAmount = 4
var currentReRoll = 0
var maxReRoll = 3


func _ready() -> void:
	SetPlayerReRollLabel()
	CheckEnemy()
	
#PlayTheDice -> randomize the number
func PlayTheDice() -> void:
	randomNumber1.randomize()
	p1Roll = randomNumber1.randi_range(1, 6)
	dice_anim.play("RollDice")
	SoundManager.PlayClip(dice_stream, SoundManager.SFX_ROLLDICE)

func SetPlayerReRollLabel() -> void:
	max_rerrolLabel.text = "Rerrol %d/%d" % [currentReRoll, maxReRoll] 

func CheckEnemy() -> void:
	if(!isPlayer):
		roll_button.visible = false
		reroll_button.visible = false
		enemy_timer.start()

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
	currentReRoll += 1
	PlayTheDice()
	SetPlayerReRollLabel()
	if(currentReRoll == maxReRoll):
		reroll_button.disabled = true

func _on_enemy_timer_timeout() -> void:
	PlayTheDice()
