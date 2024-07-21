extends Node2D

@onready var transition: AnimationPlayer = $TradeUI/Transition
@onready var season_inf: Label = $TradeUI/MC/SeasonInf
@onready var season_icon: TextureRect = $TradeUI/SeasonIcon
@onready var money: Label = $TradeUI/MC/Money

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetPlayerMoneyLabel()
	SetSeasonLabel()
	SetTextureIcon()
	transition.play("fadeIn")

func SetTextureIcon() -> void:
	var iconSeason = Global.GetCurrentIconSeason()
	season_icon.texture = iconSeason
	season_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH

func SetSeasonLabel() -> void:
	season_inf.text = Global.GetCurrentSeason()

func SetPlayerMoneyLabel() -> void:
	money.text = "Money: %d" % [Global.playerMoney]

func _on_buy_bt_pressed() -> void:
	print("Opening buying menu!!")


func _on_sell_bt_pressed() -> void:
	print("Opening sell menu!")


func _on_gb_bt_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)
