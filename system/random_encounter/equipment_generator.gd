extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	match get_parent().characterType:
		Global.character.GOBLIN:
			generateWeapon(Equipment.GOBLIN_WEAPONS, randi_range(0,Equipment.GOBLIN_WEAPONS.size() - 1))
			generateArmor(Equipment.GOBLIN_ARMORS, randi_range(0,Equipment.GOBLIN_ARMORS.size() - 1))
		Global.character.UNDEAD:
			generateWeapon(Equipment.UNDEAD_WEAPONS, randi_range(0,Equipment.UNDEAD_WEAPONS.size() - 1))
			#generateArmor(randi_range(0,Equipment.GOBLIN_ARMORS.size() - 1))
		Global.character.REAPER:
			#generateWeapon(randi_range(0,Equipment.GOBLIN_WEAPONS.size() - 1))
			generateArmor(Equipment.REAPER_AMORS, randi_range(0,Equipment.REAPER_AMORS.size() - 1))
		Global.character.GHOST_WOLF:
			#generateWeapon(randi_range(0,Equipment.GOBLIN_WEAPONS.size() - 1))
			generateArmor(Equipment.GHOST_WOLF_ARMORS, randi_range(0,Equipment.GHOST_WOLF_ARMORS.size() - 1))
		_:
			generateWeapon(Equipment.GOBLIN_WEAPONS, randi_range(0,Equipment.GOBLIN_WEAPONS.size() - 1))
			generateArmor(Equipment.GOBLIN_ARMORS, randi_range(0,Equipment.GOBLIN_ARMORS.size() - 1))
	queue_free()

func generateWeapon(weaponArray, value):
	get_parent().weapon = weaponArray[value].instantiate()

func generateArmor(armorArray,value):
	get_parent().armor = armorArray[value].instantiate()
