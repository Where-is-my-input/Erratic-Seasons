extends Node2D

@onready var transition: AnimationPlayer = $Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fadeIn")


func _on_buy_bt_pressed() -> void:
	print("Opening buying menu!!")


func _on_sell_bt_pressed() -> void:
	print("Opening sell menu!")


func _on_gb_bt_pressed() -> void:
	get_tree().change_scene_to_packed(Global.OwScene)
