extends CharacterBody2D

const SPEED :float = 300.0
const JUMP_VELOCITY:float = -750.0
@onready var button: TouchScreenButton = %Button
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var manager: Node = $"../Manager"
var can_jump:bool = false
var number = 0 :
    set(value):
        number = value
        if number == 1:
            can_jump = false
            number = 0
    get:
        return number
func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
    if is_on_floor():
        number = 0
        can_jump = true
    move_and_slide()
func _ready() -> void:
    button.pressed.connect(func():
        if can_jump:
            number += 1
            velocity.y = JUMP_VELOCITY
        )


func _on_edge_body_entered(body: Node2D) -> void:
    if body == self:
        manager.emit_signal("game_over",$"..")
    if body is RigidBody2D:
        body.get_node("AnimationPlayer").play("die")
