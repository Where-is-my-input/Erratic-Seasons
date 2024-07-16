extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	match get_parent().characterType:
		Global.character.GOBLIN:
			generateWeapon(randi_range(0,Equipment.GOBLIN_WEAPONS.size() - 1))
			generateArmor(randi_range(0,Equipment.GOBLIN_ARMORS.size() - 1))
	queue_free()

func generateWeapon(value):
	get_parent().weapon = Equipment.GOBLIN_WEAPONS[value].instantiate()

func generateArmor(value):
	get_parent().armor = Equipment.GOBLIN_ARMORS[value].instantiate()
