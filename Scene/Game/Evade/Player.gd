extends CharacterBody2D

const SPEED :float = 300.0
const JUMP_VELOCITY:float = -550.0
@onready var button: Button = %Button
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var manager: Node = $"../Manager"

func _physics_process(delta: float) -> void:
	if velocity.y > 0:
		animation_player.play("jump")
	elif velocity.y < 0:
		animation_player.play("fall")
	else:
		animation_player.play("idle")
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
func _ready() -> void:
	button.button_up.connect(func():
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		)


func _on_area_2d_area_entered(area: Area2D) -> void:
	manager.emit_signal("game_over",$"..")
