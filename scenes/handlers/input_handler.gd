class_name InputHandler
extends Node2D


func movement_input()->void:
	return Input.is_action_just_pressed("thrust")

