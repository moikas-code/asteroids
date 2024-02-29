extends Node2D
class_name GameManager

var time:int = 0
@export var max_lives:int = 1
var current_lives:int = 0
signal on_time_add


func _ready()->void:
	current_lives = max_lives
	SignalBus.on_player_death.connect(on_player_death)
	SignalBus.on_game_over.connect(on_game_over)
	

func get_time()->int:
	return time

func add_time(value:int)->void:
	time += value

func on_player_death()->void:
	current_lives -= 1
	print(current_lives)
	if current_lives == 0:
		print('true')
		SignalBus.emit_on_game_over()
		
func on_game_over()->void:
	get_tree().change_scene_to_packed(load('res://scenes/game_end.tscn'))
