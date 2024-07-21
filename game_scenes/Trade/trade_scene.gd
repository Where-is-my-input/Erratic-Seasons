extends Node2D

@onready var transition: AnimationPlayer = $TradeUI/Transition
@onready var season_inf: Label = $TradeUI/MC/SeasonInf
@onready var money: Label = $TradeUI/MC/Money
@onready var mc: MarginContainer = $TradeUI/MC
@onready var buy_menu: CanvasLayer = $TradeUI/BuyMenu
@onready var sell_menu: CanvasLayer = $TradeUI/SellMenu
@onready var season_icon: TextureRect = $TradeUI/SeasonIcon
var isBuyingStoreOpened = false
var isSellingStoreOpened = false
var menusOpened = 0
var maxMenuAllowed = 1 as int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buy_menu.on_object_bought.connect(OnObjectBought)
	buy_menu.visible = false
	sell_menu.visible = false
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
	OpenBuyMenu()

func OpenBuyMenu() -> void:
	sell_menu.visible = false
	isBuyingStoreOpened = !isBuyingStoreOpened
	buy_menu.visible = isBuyingStoreOpened

func _on_sell_bt_pressed() -> void:
	print("Opening sell menu!")
	OpenSellMenu()

func OpenSellMenu() -> void:
	buy_menu.visible = false
	isSellingStoreOpened = !isSellingStoreOpened
	sell_menu.visible = isSellingStoreOpened

func OnObjectBought() -> void:
	SetPlayerMoneyLabel()

func _on_gb_bt_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)
