extends Control
class_name GameEnd
@onready var retry = %Retry
@onready var menu = %Menu

func _ready()->void:
	menu.pressed.connect(onMenu)
	retry.pressed.connect(onRetry)
	
func onMenu()->void:
	pass

func onRetry()->void:
	get_tree().change_scene_to_packed(load("res://scenes/main.tscn"))
