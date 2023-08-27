extends Node2D

@onready var _manager:Node = $Manager
@onready var _score_node: Area2D = $Node2D/Score

var _bonus:int = 50
var _move_speed:int = 300

func _ready() -> void:
	_score_node.body_entered.connect(func(body):
		if body.get("TYPE") == null:
			return
		_manager.score_bonus.emit(_bonus)        
		)

func _physics_process(delta: float) -> void:
	position.x -= delta * _move_speed
