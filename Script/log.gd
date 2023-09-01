extends Control
@onready var label:Label = $ColorRect/Label
@onready var animation_player:AnimationPlayer = $AnimationPlayer

func set_text(text:String) -> void:
    label.text = text
func _ready() -> void:
    animation_player.animation_finished.connect(self.queue_free)
