extends Node2D

const speed:int = 200

func _physics_process(delta: float) -> void:
    position.y += delta * speed
