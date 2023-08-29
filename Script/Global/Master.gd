extends Node

var _game_over_scene := preload("res://Scene/GameOver.tscn")
var _total_score:int = 0
var _last_score:int = 0
var UI:CanvasLayer
var camera_node:Camera2D
var _score_list:Array :
    set(value):
        _score_list = value
        RankList.get_node("RankList").get_node("RankPanel").get_node("ScrollContainer").get_node("Ranker").emit_signal("changed")
    get:
        return _score_list
var gamesaver:GamerSaver = GamerSaver.new()
func _ready() -> void:
    pass
    
func move_camera_to_node(node:Node) -> void:
    camera_node.zoom = Vector2(1.8, 1.8)
    camera_node.global_position = node.global_position

func get_total_score() -> int:
    return _total_score

func get_last_score() -> int:
    return _last_score

func set_last_score(value:int) -> void:
    _last_score = value
    _score_list.append(_last_score)
    if _score_list.size() > 20:
        _score_list.erase(_score_list.back())
    _score_list.sort()
    _score_list.reverse()
    RankList.get_node("RankList").get_node("RankPanel").get_node("ScrollContainer").get_node("Ranker").emit_signal("changed")
func score_to_zero() -> void:
    _total_score = 0

func bonus_points(value:int) -> void:
    _total_score += value

func penalty_points(value:int) -> void:
    pass

func game_over() -> void:
    get_tree().change_scene_to_packed(_game_over_scene)
func save_game():
    var game = GamerSaver.new()
    game.mute = Setting.get_node("Setting").check_box.button_pressed
    game.volume = Setting.get_node("Setting").h_slider.value
    game.score = Master._score_list
    ResourceSaver.save(game,"user://game.tres")
    LogManager.add_log("已保存游戏")
func load_game():
    gamesaver = ResourceLoader.load("user://game.tres")
    if gamesaver == null:
        LogManager.add_log("读取失败")
        return
    Master._score_list = gamesaver.score
    Setting.get_node("Setting").h_slider.value = gamesaver.volume
    Setting.get_node("Setting").check_box.button_pressed = gamesaver.mute
    Setting.get_node("Setting").button.emit_signal("pressed")
    LogManager.add_log("已读取游戏")
