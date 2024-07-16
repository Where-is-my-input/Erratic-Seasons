extends HBoxContainer
@onready var lbl_name = $lblName
@onready var equip_type = $equipType
@onready var value = $value
@onready var level = $level

func init(equipment):
	lbl_name.text = equipment.equipmentName
	level.text = str(equipment.level)
	if equipment.equipmentType == Global.equipmentType.ARMOR:
		equip_type.text = "Armor"
		value.text = str(equipment.def)
	else:
		equip_type.text = "Weapon"
		value.text = str(equipment.atk)
