extends Control
class_name GameStart
@onready var exit = %Exit
@onready var menu = %Menu

func _ready()->void:
	menu.pressed.connect(onMenu)
	exit.pressed.connect(onExit)
	
func onMenu()->void:
	get_tree().change_scene_to_packed(load("res://scenes/main.tscn"))

func onExit()->void:
	get_tree().quit()
