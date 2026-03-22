extends CharacterBody2D

@export var speed = 150

var last_direction: String = "down"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
	var move_direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		move_direction.x = 1
	elif Input.is_action_pressed("left"):
		move_direction.x = -1

	if Input.is_action_pressed("down"):
		move_direction.y = 1
	elif Input.is_action_pressed("up"):
		move_direction.y = -1

	velocity = move_direction.normalized() * speed
	move_and_slide()

	if move_direction == Vector2.ZERO:
		animation_player.stop()
		sprite.frame = get_idle_frame()
	else:
		if move_direction.y > 0:
			last_direction = "down"
		elif move_direction.y < 0:
			last_direction = "up"
		elif move_direction.x > 0:
			last_direction = "right"
		elif move_direction.x < 0:
			last_direction = "left"

		var anim = "walk_" + last_direction
		if animation_player.current_animation != anim:
			animation_player.play(anim)

func get_idle_frame() -> int:
	match last_direction:
		"up":    return 1
		"left":  return 13
		"down":  return 26
		"right": return 39
	return 1
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T and TaskStorage.has_job:
			get_tree().change_scene_to_file(
				"res://scenes/accepted_tasks.tscn"
			)
