extends Node2D

@onready var _edge:Area2D = $Edge
@onready var _manager:Node = $Manager

func _ready() -> void:
    _edge.body_entered.connect(func(body):
        if body.get("TYPE") != null:
            _manager.game_over.emit(self)
        body.queue_free()
        )
