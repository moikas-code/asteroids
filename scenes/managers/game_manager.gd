extends Node2D
class_name GameManager

var time:int = 0

signal on_time_add

func _ready()->void:
	pass

func get_time()->int:
	return time

func add_time(value:int)->void:
	time += value
