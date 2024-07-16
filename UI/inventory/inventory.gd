extends Control
@onready var v_box_container = $VBoxContainer

const INVENTORY_ITEM = preload("res://UI/inventory/inventory_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	loadInventory()

func loadInventory():
	for e in Global.playerInventory:
		var equip = INVENTORY_ITEM.instantiate()
		v_box_container.add_child(equip)
		equip.init(e)
