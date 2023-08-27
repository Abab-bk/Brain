extends Node2D

@onready var pipe := preload("res://Scene/Game/FlappyBrid/Pipe.tscn")
@onready var timer:Timer = $PipesTimer

var interval:int = 4

func _ready() -> void:
	timer.timeout.connect(self.timeout)
	timer.wait_time = interval
	timer.start()

func timeout() -> void:
	var new_pipe = pipe.instantiate()
	new_pipe.position = Vector2(1670, randi_range(202, 844))
	add_child(new_pipe)
