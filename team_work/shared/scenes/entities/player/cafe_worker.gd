extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var prompt = $Label

var player_nearby = false

func _ready():
	animation_player.play("idle_down")
	prompt.visible = false

func _process(_delta):
	if player_nearby and Input.is_key_pressed(KEY_E):
		get_tree().change_scene_to_file(
			"res://scenes/entities/player/cafe_interaction.tscn"
		)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_nearby = true
		prompt.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_nearby = false
		prompt.visible = false
