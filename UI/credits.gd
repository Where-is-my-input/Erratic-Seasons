extends Control


func _on_back_pressed():
	get_parent().visible = false
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
