extends Control

@onready var _camera_node:Camera2D = $Camera2D
@onready var _texture_button: TextureButton = %PauseBtn

func _ready() -> void:
    Master.used_levels.clear()
    Master.camera_node = _camera_node
    _texture_button.button_up.connect(func():
        Setting.visible = true
        Engine.time_scale = 1
        )
    _texture_button.mouse_entered.connect(func():
        Engine.time_scale = 0.3
        )
    _texture_button.mouse_exited.connect(func():
        Engine.time_scale = 1
        )
