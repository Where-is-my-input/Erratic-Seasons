extends CanvasLayer

@onready var items_panel: Panel = $ItemsPanel
@onready var equipments_menu: Panel = $EquipmentsMenu
@onready var v_box_buy_items_buttons: VBoxContainer = $ItemsPanel/MarginContainer/VBoxBuyButtons
@onready var zero_money_item_warning: Label = $ItemsPanel/MarginContainer/ZeroMoneyWarning
@onready var zero_money_equip_warning: Label = $EquipmentsMenu/MarginContainer/ZeroMoneyEquipWarning
@onready var v_box_buy_equip_buttons: VBoxContainer = $EquipmentsMenu/MarginContainer/VBoxBuyEquipButtons
@onready var not_enough_equip_m: Label = $EquipmentsMenu/NotEnoughEquipM
@onready var not_enough_item_m: Label = $ItemsPanel/NotEnoughItemM


const POTION_PRICE = 100 as int
const OLD_CLUB_PRICE = 150 as int
const EARTH_DAGGER_PRICE = 180 as int
const BROKEN_SHIELD_PRICE = 50 as int
const BUBBLE_SHIELD_PRICE = 120 as int

signal on_object_bought()

func _on_nxt_button_pressed() -> void:
	items_panel.visible = false
	equipments_menu.visible = true

func _on_back_button_pressed() -> void:
	equipments_menu.visible = false
	items_panel.visible = true

func WithDrawPlayerMoney(withDrawAmount : int) -> void:
	var isBuyable = BuySecurity(withDrawAmount)
	if(isBuyable):
		Global.playerMoney -= withDrawAmount
	else:
		not_enough_equip_m.visible = true
		not_enough_item_m.visible = true
		return
	if(Global.playerMoney <= 0):
		zero_money_item_warning.visible = true
		zero_money_equip_warning.visible = true
		for buyButton in v_box_buy_items_buttons.get_children():
			if(buyButton.is_in_group("BuyButton")):
				buyButton.disabled = true
		for buyButton in v_box_buy_equip_buttons.get_children():
			if(buyButton.is_in_group("BuyButton")):
				buyButton.disabled = true
				

func BuySecurity(withDrawAmount : int) -> bool:
	var canBuyIt = false
	if(Global.playerMoney < withDrawAmount):
		canBuyIt = false
		print("Can't buy it")
	else:
		canBuyIt = true
		print("Can buy it")
	return canBuyIt
		
#buy potion button
func _on_button_pressed() -> void:
	WithDrawPlayerMoney(POTION_PRICE)
	Global.playerItems.push_back(preload("res://equipment/items/small_potion.tscn").instantiate())
	on_object_bought.emit()
		
#Old Club
func _on_equip_one_button_pressed() -> void:
	WithDrawPlayerMoney(OLD_CLUB_PRICE)
	Global.playerInventory.push_back(preload("res://equipment/weapon/old_club.tscn").instantiate())
	on_object_bought.emit()

#Earth Dagger
func _on_equip_one_button_2_pressed() -> void:
	WithDrawPlayerMoney(EARTH_DAGGER_PRICE)
	Global.playerInventory.push_back(preload("res://equipment/weapon/earth_dagger.tscn").instantiate())
	on_object_bought.emit()

#Broken Shield
func _on_equip_one_button_3_pressed() -> void:
	WithDrawPlayerMoney(BROKEN_SHIELD_PRICE)
	Global.playerInventory.push_back(preload("res://equipment/armor/broken_shield.tscn").instantiate())
	on_object_bought.emit()

#Bubble Shield
func _on_equip_one_button_4_pressed() -> void:
	WithDrawPlayerMoney(BUBBLE_SHIELD_PRICE)
	Global.playerInventory.push_back(preload("res://equipment/armor/bubble_shield.tscn").instantiate())
	on_object_bought.emit()
