extends Node2D

@onready var _spike := preload("res://Scene/Game/Chrome/Spike.tscn")
@onready var _timer:Timer = $SpikeTimer

var _interval:int = 4

func _ready() -> void:
    _timer.timeout.connect(self.timeout)
    _timer.wait_time = _interval
    _timer.start()

func timeout() -> void:
    var new_spike = _spike.instantiate()
    new_spike.position = Vector2(1638, 885)
    add_child(new_spike)
