extends Control

func _ready():
	$Panel/task1.text = "1. " + TaskStorage.task1
	$Panel/task2.text = "2. " + TaskStorage.task2
	$Panel/task3.text = "3. " + TaskStorage.task3

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
