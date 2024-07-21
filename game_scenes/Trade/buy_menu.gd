extends CanvasLayer

@onready var items_panel: Panel = $ItemsPanel
@onready var equipments_menu: Panel = $EquipmentsMenu
@onready var v_box_buy_buttons: VBoxContainer = $ItemsPanel/MarginContainer/VBoxBuyButtons
@onready var zero_money_warning: Label = $ItemsPanel/MarginContainer/ZeroMoneyWarning

const POTION_PRICE = 100 as int

signal on_object_bought()

func _on_nxt_button_pressed() -> void:
	items_panel.visible = false
	equipments_menu.visible = true

func _on_back_button_pressed() -> void:
	equipments_menu.visible = false
	items_panel.visible = true


	
#buy potion button
func _on_button_pressed() -> void:
	Global.playerItems.push_back(preload("res://equipment/items/small_potion.tscn").instantiate())
	WithDrawPlayerMoney(POTION_PRICE)
	on_object_bought.emit()

func WithDrawPlayerMoney(withDrawAmount : int) -> void:
	Global.playerMoney -= withDrawAmount
	if(Global.playerMoney <= 0):
		zero_money_warning.visible = true
		for buyButton in v_box_buy_buttons.get_children():
			if(buyButton.is_in_group("BuyButton")):
				buyButton.disabled = true
