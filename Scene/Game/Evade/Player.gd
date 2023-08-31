extends CharacterBody2D

const _jump_velocity:float = -550.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_jump:String = "jump"
var can_jump:bool = false
var number = 0 :
    set(value):
        number = value
        if number == 1:
            current_jump = "double_jump"
            can_jump = false
            number = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var manager: Node = $"../Manager"
@onready var button: TouchScreenButton = %Button

func _physics_process(delta: float) -> void:
    if velocity.y > 0:
        animation_player.play(current_jump)
            
    elif velocity.y < 0:
        animation_player.play("fall")
    else:
        animation_player.play("idle")
    if not is_on_floor():
        velocity.y += gravity * delta
    if is_on_floor():
        number = 0
        can_jump = true
        current_jump = "jump"
    move_and_slide()
func _ready() -> void:
    button.pressed.connect(func():
        if can_jump:
            number += 1
            velocity.y = _jump_velocity
        )

func _on_area_2d_area_entered(area: Area2D) -> void:
    manager.emit_signal("game_over",$"..")
