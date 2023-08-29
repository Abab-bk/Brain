extends Area2D
@export var direction:Vector2 = Vector2.RIGHT
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var manager: Node = $"../../Manager"
@onready var player: CharacterBody2D = $"../../Player"

signal state_changed
enum {
    IDLE,
    PREKNOCK,
    KNOCK,
}
var state:int = IDLE :
    set(value):
        state = value
        emit_signal("state_changed")
    get:
        return state
func _ready() -> void:
    connect("state_changed",Callable(self,"change_state"))
    emit_signal("state_changed")
    if is_in_group("hazardous_materials"):
        randomize()
        direction = Vector2(randf_range(-1,1),randf_range(-1,1))
func change_state() -> void:
    match state:
        IDLE:
            idle()
        PREKNOCK:
            preknock()
        KNOCK:
            knock()
##状态
func idle() -> void:
    randomize()
    animation_player.play("idle")
    var random_number:float=randf_range(2.0,5.0)
    await get_tree().create_timer(random_number).timeout
    state = PREKNOCK
func preknock() -> void:
    randomize()
    animation_player.play("eye")
    var random_number:float = randf_range(0.5,1.5)
    await animation_player.animation_finished
    await get_tree().create_timer(random_number).timeout
    state = KNOCK
func knock() -> void:
    animation_player.play("knock")
    var tweens := create_tween()
    tweens.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
    tweens.tween_property(self, "position", Vector2(160,160)*direction, 0.5)
    tweens.tween_property(self, "position",Vector2.ZERO, 0.5)
    state = IDLE
    if not is_in_group("hazardous_materials"):
        manager.emit_signal("score_bonus",10)
