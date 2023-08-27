extends RigidBody2D

@onready var button:Button = %Button

const TYPE = 1
const SPEED = 300.0
const GRAVITY = 500.0

func _ready() -> void:
	button.pressed.connect(self._jump)

func _jump() -> void:
	linear_velocity = Vector2(0, -GRAVITY)
