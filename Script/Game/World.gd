extends Control

@onready var _camera_node:Camera2D = $Camera2D
@onready var _texture_button:TextureButton = %PauseBtn

func _ready() -> void:
    Master.used_levels.clear()
    Master.camera_node = _camera_node
    
    _texture_button.pressed.connect(func():
        Setting.show())
