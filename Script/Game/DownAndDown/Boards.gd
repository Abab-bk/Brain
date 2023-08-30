extends Node2D

@onready var board := preload("res://Scene/Game/DownAndDown/OneWayBoard.tscn")
@onready var timer:Timer = $BoardsTimer
@onready var manager: Node = $"../Manager"

var interval:int = 1

func _ready() -> void:
    timer.timeout.connect(self.timeout)
    timer.wait_time = interval
    timer.start()

func timeout() -> void:
    manager.emit_signal("score_bonus",5)
    var new_board = board.instantiate()
    randomize()
    new_board.position = Vector2(randi_range(600,1000), 115)
    add_child(new_board)
