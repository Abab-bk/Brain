extends Control

@onready var _camera_node:Camera2D = $Camera2D

func _ready() -> void:
    Master.camera_node = _camera_node
