extends Control

var _world_scene := preload("res://Scene/World.tscn")

func _ready() -> void:
    %Text.text = "得分：" + str(Master.get_last_score())
    %ReStartBtn.pressed.connect(func():
        get_tree().change_scene_to_packed(_world_scene))
    %RankList.pressed.connect(func():
        RankList.visible = true
        )
