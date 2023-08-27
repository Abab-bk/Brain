extends CharacterBody2D

@onready var button:Button = %Button

const TYPE = 1
const JUMP_VELOCITY = -500.0


var gravity:int = 800

func _ready() -> void:
	button.pressed.connect(self._jump)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	
	move_and_slide()

func _jump() -> void:
	if not is_on_floor():
		return
	velocity.y = JUMP_VELOCITY
