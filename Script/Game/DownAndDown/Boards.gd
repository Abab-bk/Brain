extends Node2D

const SIZE:Vector2 = Vector2(600,1000)
const INIT_POSITION_Y:int = 115

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
    new_board.position = Vector2(randi_range(SIZE.x,SIZE.y), INIT_POSITION_Y)
    add_child(new_board)
