extends Node2D

@onready var board := preload("res://Scene/Game/DownAndDown/OneWayBoard.tscn")
@onready var timer:Timer = $BoardsTimer

var interval:int = 1

func _ready() -> void:
	timer.timeout.connect(self.timeout)
	timer.wait_time = interval
	timer.start()

func timeout() -> void:
	var new_board = board.instantiate()
	new_board.position = Vector2(880, 115)
	add_child(new_board)
