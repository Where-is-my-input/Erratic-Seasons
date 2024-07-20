extends Control
@onready var rich_text_label = $RichTextLabel
#@onready var timer = $Timer
@onready var timer = $Timer

signal dismiss

func setText(value):
	#timer.start(3)
	rich_text_label.text = value
	timer.start(3)

#func _input(event):
	#if event.is_action_pressed("ui_accept") && visible: dismiss.emit()

func _on_timer_timeout():
	dismiss.emit()
