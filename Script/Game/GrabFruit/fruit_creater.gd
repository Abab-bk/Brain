extends Node2D

var fruit_scene := preload("res://Scene/Game/GrabFruit/fruit.tscn")

@onready var grab_fruit: Node2D = $".."
@onready var grab: Node2D = $"../.."
@onready var timer: Timer = $Timer
@onready var label: Label = $Text
@onready var fruit: Node2D = $fruit

@export var wait_time:int = 3

func _ready() -> void:
    end_game()
    
func _process(delta: float) -> void:
    wait_time_text()
    
func update_wait_time() -> void:
    timer.wait_time = wait_time
    timer.start()
    
func wait_time_text() -> void:
    label.text = str(int(timer.time_left)+1)

func game_start() -> void:
    set_process(false)
    label.text = ""
    grab_fruit.process_mode = Node.PROCESS_MODE_INHERIT
    if fruit.get_child_count() == 0:
        fruit.add_child(fruit_scene.instantiate())
        
func end_game() -> void:
    set_process(true)
    update_wait_time()
    timer.timeout.connect(func():
        game_start()
    )
    grab_fruit.process_mode = Node.PROCESS_MODE_DISABLED
