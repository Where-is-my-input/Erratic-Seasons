extends CanvasLayer

@onready var items_panel: Panel = $ItemsPanel
@onready var equipments_panel: Panel = $EquipmentsPanel
const HEAL_POTION_VALUE : int = 20
const OLD_CLUB_VALUE : int = 10
const EARTH_DAGGER_VALUE : int = 30
const BROKEN_SHIELD_VALUE : int = 5
const BUBBLE_SHIELD_VALUE : int = 40

func _on_next_button_pressed() -> void:
	items_panel.visible = false
	equipments_panel.visible = true

func _on_back_button_pressed() -> void:
	equipments_panel.visible = false
	items_panel.visible = true

func DepositPlayerMoney(moneyToDeposit) -> void:
	Global.playerMoney += moneyToDeposit
	
func GetPlayerItemInventory() -> void:
	#Get the player itemInv here
	pass
	
func GetPlayerEquipInventory() -> void:
	#Get the player equipInv Here
	pass
