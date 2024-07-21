extends Control
@onready var item_list = $itemList
#@onready var color_rect = $ColorRect
@onready var btn_close = $itemList/btnClose

signal closeInventory

const INVENTORY_ITEM = preload("res://UI/inventory/inventory_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	loadInventory()
	#color_rect.size = item_list.size

func loadInventory(trading = false):
	#for i in item_list.get_children(): if i is HBoxContainer: i.queue_free()
	for e in Global.playerInventory:
		var equip = INVENTORY_ITEM.instantiate()
		item_list.add_child(equip)
		equip.connect("equipEquipment", equipEquipment)
		equip.init(e, trading)

func _on_btn_close_pressed():
	clearList()
	closeInventory.emit()

func equipEquipment(equipment):
	clearList()
	closeInventory.emit(equipment)

func clearList():
	for i in item_list.get_children(): if i is HBoxContainer: i.queue_free()

func grabFocus():
	btn_close.grab_focus()
