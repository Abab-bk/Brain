extends Node2D

var speed:int = 200

func _physics_process(delta: float) -> void:
	position.y += delta * speed
