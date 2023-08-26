extends Node2D

@onready var _manager:Node = $Manager
@onready var _score_area:Area2D = $Area2D

@export var bonus:int = 20

var move_speed:int = 300

func _ready() -> void:
	_score_area.body_entered.connect(func(body):
		if body.get("TYPE") == null:
			return
		_manager.score_bonus.emit(bonus))

func _physics_process(delta: float) -> void:
	position.x -= delta * move_speed
