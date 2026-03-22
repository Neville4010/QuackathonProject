extends Control

@onready var bar = $ProgressBar
@onready var loading_text = $Label2

var progress = 0.0

func _process(delta):
	if progress < 100:
		progress += delta * 25
		bar.value = progress
		if progress >= 100:
			progress = 100
			loading_text.text = "             COMPLETE!"
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
