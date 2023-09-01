extends Node2D

@onready var timer:Timer = $Timer
@onready var player: CharacterBody2D = $"../player"
@onready var manager: Node = $"../Manager"

@export var size : int = 500

var block := preload("res://Scene/Game/SwitchParkour/block.tscn")

func _ready() -> void:
    timer.start()
    timer.timeout.connect(func():
        var _block = block.instantiate()
        randomize()
        _block.position.x = player.position.x
        add_child(_block)
        manager.emit_signal("score_bonus",5)
        )
