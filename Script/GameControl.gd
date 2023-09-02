extends Control
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

func _ready() -> void:
    Master.add_random_level(sub_viewport)
