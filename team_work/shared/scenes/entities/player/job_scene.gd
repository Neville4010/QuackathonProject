extends Node2D

var part_time_jobs = [
	{"title": "Cafe Worker", "description": "Serve coffee and clean tables.", "salary": "4hrs", "tasks": ["Greet 5 customers", "Serve 10 orders", "Clean the cafe"]},
	{"title": "Casino Dealer", "description": "Deal cards at the casino.", "salary": "4hrs", "tasks": ["Shuffle the deck", "Deal 3 rounds", "Count the chips"]},
	{"title": "Shop Assistant", "description": "Help customers find items.", "salary": "4hrs", "tasks": ["Stock the shelves", "Assist 5 customers", "Cash up the till"]}
]

var full_time_jobs = [
	{"title": "Bank Teller", "description": "Handle transactions at the bank.", "salary": "8hrs", "tasks": ["Process 10 deposits", "Handle 5 withdrawals", "Balance the books"]},
	{"title": "Casino Manager", "description": "Oversee casino operations.", "salary": "8hrs", "tasks": ["Check all tables", "Manage 3 dealers", "File end of day report"]},
	{"title": "Recruitment Manager", "description": "Help others find work.", "salary": "8hrs", "tasks": ["Interview 3 candidates", "Post 2 job listings", "Review applications"]}
]

var intro_dialogue = [
	"Welcome to the Alogo City Job Centre!",
	"Finding work is how you earn more time in this city.",
	"Choose between Part Time — 4hrs pay,",
	"or Full Time — 8hrs pay but more to do!",
	"Use arrow keys to swipe through job cards.",
	"Right arrow to ACCEPT, Left arrow to REJECT.",
	"Press T anytime to view your current tasks.",
	"Press G to give up... sucks to be you!",
	"Now let's find you a job. Good luck!"
]

var current_dialogue = 0
var current_job_index = 0
var current_jobs = []
var accepted_job = {}
var task_panel_visible = false

enum State {DIALOGUE, JOB_SELECTION, SWIPING, TASKS_ASSIGNED}
var state = State.DIALOGUE

@onready var dialogue_panel = $CanvasLayer/dialogue_panel
@onready var dialogue_label = $CanvasLayer/dialogue_panel/dialogue_label
@onready var continue_button = $CanvasLayer/dialogue_panel/Button
@onready var job_selection_panel = $CanvasLayer/jobselection_panel
@onready var swipe_panel = $CanvasLayer/swipe_panel
@onready var job_title = $CanvasLayer/swipe_panel/jobtitle
@onready var job_description = $CanvasLayer/swipe_panel/jobdescription
@onready var salary_label = $CanvasLayer/swipe_panel/salarylabel
@onready var task_panel = $CanvasLayer/TaskPanel
@onready var task1 = $CanvasLayer/TaskPanel/task1
@onready var task2 = $CanvasLayer/TaskPanel/task2
@onready var task3 = $CanvasLayer/TaskPanel/task3

func _ready():
	dialogue_panel.visible = true
	job_selection_panel.visible = false
	swipe_panel.visible = false
	task_panel.visible = false
	dialogue_label.text = intro_dialogue[0]
	continue_button.pressed.connect(_on_continue_pressed)
	$CanvasLayer/jobselection_panel/parttime_button.pressed.connect(_on_parttime_pressed)
	$CanvasLayer/jobselection_panel/fulltime_button.pressed.connect(_on_fulltime_pressed)

func _on_continue_pressed():
	current_dialogue += 1
	if current_dialogue < intro_dialogue.size():
		dialogue_label.text = intro_dialogue[current_dialogue]
	else:
		dialogue_panel.visible = false
		job_selection_panel.visible = true
		state = State.JOB_SELECTION

func _on_parttime_pressed():
	current_jobs = part_time_jobs
	start_swiping()

func _on_fulltime_pressed():
	current_jobs = full_time_jobs
	start_swiping()

func start_swiping():
	current_job_index = 0
	job_selection_panel.visible = false
	swipe_panel.visible = true
	state = State.SWIPING
	show_current_job()

func show_current_job():
	var job = current_jobs[current_job_index]
	job_title.text = job["title"]
	job_description.text = job["description"]
	salary_label.text = "Salary: " + job["salary"]

func _input(event):
	if state == State.SWIPING:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_RIGHT:
				accept_job()
			elif event.keycode == KEY_LEFT:
				reject_job()
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_G and state == State.TASKS_ASSIGNED:
			give_up()
		if event.keycode == KEY_T and state == State.TASKS_ASSIGNED:
			toggle_task_panel()

func reject_job():
	current_job_index += 1
	if current_job_index >= current_jobs.size():
		current_job_index = 0
	show_current_job()

func accept_job():
	accepted_job = current_jobs[current_job_index]
	swipe_panel.visible = false
	task_panel.visible = true
	task1.text = "1. " + accepted_job["tasks"][0]
	task2.text = "2. " + accepted_job["tasks"][1]
	task3.text = "3. " + accepted_job["tasks"][2]
	state = State.TASKS_ASSIGNED

func toggle_task_panel():
	if task_panel_visible:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		task_panel_visible = true
		task_panel.visible = true

func give_up():
	task_panel.visible = false
	task_panel_visible = false
	dialogue_panel.visible = true
	dialogue_label.text = "Sucks to be you! Back to the city!"
	continue_button.pressed.connect(
		func(): get_tree().change_scene_to_file("res://scenes/game.tscn")
	)
