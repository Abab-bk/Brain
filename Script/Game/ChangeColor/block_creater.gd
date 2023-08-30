extends Node2D
var _yellow := preload("res://Scene/Game/ChangeColor/yellow.tscn")
var _pink := preload("res://Scene/Game/ChangeColor/pink.tscn")
@onready var _node_pink: Node2D = $pink
@onready var _node_yellow: Node2D = $yellow
@onready var manager: Node = $"../Manager"
@onready var player: CharacterBody2D = $"../player"

@export var size : int
func _ready() -> void:
    $Timer.start()
    randomize()
    var pink = _pink.instantiate()
    pink.position.y = randi_range(-size,size)
    _node_pink.add_child(pink)
func _on_timer_timeout() -> void:
    random()
func random() -> void:
    manager.emit_signal("score_bonus",2)
    randomize()
    var number:int = randi_range(0,1)
    var select:bool = true if number == 0 else false
    if select:
        randomize()
        var pink = _pink.instantiate()
        pink.position.y = randi_range(-size,size)
        _node_pink.add_child(pink)
    elif not select:
        randomize()
        var yellow = _yellow.instantiate()
        yellow.position.y = randi_range(-size,size)
        _node_yellow.add_child(yellow)
