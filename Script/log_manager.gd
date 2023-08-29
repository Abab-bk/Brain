extends CanvasLayer
var Log := preload("res://Scene/log.tscn")
@onready var logs: Control = $Logs
@export var delay:float = 0.2

func add_log(text:String) -> void:
    var _log = Log.instantiate()
    logs.add_child(_log)
    _log.set_text(text)

func add_logs(texts:Array[String]) -> void:
    for _texts in texts:
        await get_tree().create_timer(delay).timeout
        add_log(_texts)

func close_logs() -> void:
    logs.hide()

func set_delay(_delay:float) -> void:
    delay = _delay
