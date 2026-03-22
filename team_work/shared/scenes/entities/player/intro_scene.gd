extends Control

var dialogue = [
	"Welcome to Alogo City — a place where every second counts!",
	"Time is your most valuable currency here.",
	"You start with 12 hours — use them wisely!",
	"Complete tasks around the city to earn more time.",
	"Spend carefully — every decision matters.",
	"Explore the city and talk to NPCs to find work.",
	"Oh and don't forget to check out the Casino... 
	if you're feeling lucky!",
	"Remember one thing... TIME IS MONEY!",
	"Good luck out there — Alogo City is waiting for you!"
]

var current_line = 0

@onready var label = $Panel/Label
@onready var button = $Panel/Button

func _ready():
	label.text = dialogue[current_line]
	button.pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
	current_line += 1
	if current_line < dialogue.size():
		label.text = dialogue[current_line]
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
