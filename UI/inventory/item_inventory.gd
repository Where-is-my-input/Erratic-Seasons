extends Control
@onready var item_list = $itemList
#@onready var color_rect = $ColorRect

signal closeItemInventory

const INVENTORY_ITEM = preload("res://UI/inventory/item_list_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	loadInventory()
	#color_rect.size = item_list.size

func loadInventory(trading = false):
	for e in Global.playerItems:
		var equip = INVENTORY_ITEM.instantiate()
		item_list.add_child(equip)
		equip.connect("useItem", useItem)
		equip.init(e, trading)

func _on_btn_close_pressed():
	#clearInventory()
	closeItemInventory.emit()
	#loadInventory()

func useItem(itemUsed):
	clearInventory()
	closeItemInventory.emit(itemUsed)
	loadInventory()

func clearInventory():
	for i in item_list.get_children(): if i is HBoxContainer: i.queue_free()
