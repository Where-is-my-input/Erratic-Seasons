extends HBoxContainer
@onready var lbl_name = $lblName
@onready var lbl_value = $lblValue
@onready var price = $price
@onready var btn_use = $btnUse

signal useItem

var itemRef

func init(item, trading = false):
	itemRef = item
	lbl_name.text = item.itemName
	lbl_value.text = str(item.effectValue)
	
	if trading:
		price.text = str(item.cost)
		price.visible = true
		btn_use.visible = false

func _on_btn_use_pressed():
	useItem.emit(itemRef)
