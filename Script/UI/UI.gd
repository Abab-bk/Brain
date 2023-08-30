extends CanvasLayer

@onready var _point_node:Label = %Point

func _ready() -> void:
    Master.UI = self
    update_ui()

func update_ui() -> void:
    _point_node.text = "得分：" + str(Master.get_total_score())
