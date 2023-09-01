extends Node2D

@onready var sprite_2d:Sprite2D = $Sprite2D
@onready var area_2d:Area2D = $Fr
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $Fr/CollisionShape2D

var manager:Manager
var fruits_textures:Array = [
    preload("res://Assets/Texture/Game/Items/Fruits/Apple.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Bananas.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Cherries.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Kiwi.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Melon.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Orange.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Pineapple.png"),
    preload("res://Assets/Texture/Game/Items/Fruits/Strawberry.png")
]
func _ready() -> void:
    randomize()
    sprite_2d.texture = fruits_textures[randi_range(0,7)]
    area_2d.area_entered.connect(Callable(self,"touch_fruit"))
func touch_fruit(area:Area2D) -> void:
    if area.name == "Fr":
        return
    animation_player.play("touch")
    collision_shape_2d.set_deferred("disabled",true)
    await get_tree().create_timer(1.0).timeout
    queue_free()
    get_parent().get_parent().grab.reload_scene()
    if area.is_in_group("player"):
        manager.emit_signal("score_bonus",10)
    elif area.is_in_group("enemy"):
        manager.emit_signal("game_over",area.get_parent())
