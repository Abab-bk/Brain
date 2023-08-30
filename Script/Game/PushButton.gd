extends Node2D

@onready var _manager: Node = $Manager
@onready var _animation:AnimationPlayer = $AnimationPlayer
@onready var _progress:ProgressBar = %ProgressBar
@onready var _timer:Timer = $Timer
@onready var _button: TouchScreenButton = %Button

@export var bonus:int = 10

var _hp:int = 100:
    set(n):
        if n >= 100:
            n = 100
        if n <= 0:
            n = 0
        _hp = n
var _dps:int = 15
var _dps_plus:int = 10

func _ready() -> void:
    _timer.wait_time = 1
    _timer.timeout.connect(self._reduce_hp)
    _button.pressed.connect(self._button_press)
    _progress.value_changed.connect(func(value:float):
        if int(value) == 0:
            _manager.game_over.emit(self))
    
    _update_ui()
    _timer.start()

func _button_press() -> void:
    print("CAO")
    _hp += _dps_plus
    if not _progress.value == _progress.max_value:
        _manager.score_bonus.emit(bonus)
    _animation.play("press")
    _update_ui()
    await _animation.animation_finished
    _animation.play_backwards("press")

func _reduce_hp() -> void:
    _hp -= _dps
    _update_ui()

func _update_ui() -> void:
    _progress.value = _hp
