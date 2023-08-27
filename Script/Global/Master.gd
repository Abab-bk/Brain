extends Node

var _game_over_scene := preload("res://Scene/GameOver.tscn")
var _total_score:int = 0
var _last_score:int = 0
var UI:CanvasLayer
var camera_node:Camera2D

func move_camera_to_node(node:Node) -> void:
	camera_node.zoom = Vector2(1.8, 1.8)
	camera_node.global_position = node.global_position

func get_total_score() -> int:
	return _total_score

func get_last_score() -> int:
	return _last_score

func set_last_score(value:int) -> void:
	_last_score = value

func score_to_zero() -> void:
	_total_score = 0

func bonus_points(value:int) -> void:
	_total_score += value

func penalty_points(value:int) -> void:
	pass

func game_over() -> void:
	get_tree().change_scene_to_packed(_game_over_scene)
