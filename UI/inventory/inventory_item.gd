extends HBoxContainer
@onready var lbl_name = $lblName
@onready var equip_type = $equipType
@onready var value = $value
@onready var level = $level
@onready var price = $price
@onready var btn_equip = $btnEquip

func init(equipment, trading = false):
	lbl_name.text = equipment.equipmentName
	level.text = str(equipment.level)
	if equipment.equipmentType == Global.equipmentType.ARMOR:
		equip_type.text = "Armor"
		value.text = str(equipment.def)
	else:
		equip_type.text = "Weapon"
		value.text = str(equipment.atk)
	if trading:
		price.text = str(equipment.cost)
		price.visible = true
		btn_equip.visible = false
