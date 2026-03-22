extends Control

@onready var mocha_button = $ColorRect/Panel/mochabutton
@onready var matcha_button = $ColorRect/Panel/Matchabutton
@onready var thank_you_label = $ColorRect/Panel/thankyoulabel
@onready var sub_label = $ColorRect/Panel/sublabel

func _ready():
	thank_you_label.visible = false
	mocha_button.pressed.connect(_on_mocha_pressed)
	matcha_button.pressed.connect(_on_matcha_pressed)

func _on_mocha_pressed():
	show_thank_you("mocha", "2hrs")

func _on_matcha_pressed():
	show_thank_you("matcha", "4hrs")

func show_thank_you(drink: String, time: String):
	mocha_button.visible = false
	matcha_button.visible = false
	sub_label.visible = false
	thank_you_label.visible = true
	thank_you_label.text = "Thank you for ordering a " + drink + "!\nCome back next time for new drinks.\nLeaving in 4 seconds..."
	var timer = get_tree().create_timer(4.0)
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/levels/game.tscn")
