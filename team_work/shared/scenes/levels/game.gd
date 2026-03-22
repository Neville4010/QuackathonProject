extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cafe_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/entities/player/cafe_interaction.tscn")
	pass # Replace with function body.


func _on_bank_pressed() -> void:
	get_tree().change_scene_to_file("res://bankgame.tscn")
	pass # Replace with function body.


func _on_job_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/entities/player/job_scene.tscn")
	pass # Replace with function body.
