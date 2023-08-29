extends Node2D
@onready var maker: Node2D = $maker
@onready var timer: Timer = $Timer

var hazardous_materials:Array = [
    preload("res://Scene/Game/SwitchParkour/splike.tscn"),
    preload("res://Scene/Enemy/enemy.tscn"),
    preload("res://Scene/Game/SwitchParkour/wheel.tscn")
]
func _random_hazardous_materials_scene() -> Node:
    randomize()
    return hazardous_materials[randi_range(0,(hazardous_materials.size()-1))].instantiate()
func _marker_add_scene() -> void:
    for nodes in maker.get_children():
        nodes.add_child(_random_hazardous_materials_scene())
func _random_remove_node() -> void:
    randomize()
    maker.get_child(randi_range(0,1)).queue_free()
func _ready() -> void:
    _random_remove_node()
    _marker_add_scene()
    timer.timeout.connect(Callable(self,"queue_free"))
