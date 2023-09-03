extends VBoxContainer

var item := preload("res://Scene/Item.tscn")

@onready var texture_button: TextureButton = %"TextureButton"
#@onready var rank_list:Control = $"../.."

signal changed

func _ready() -> void:
    texture_button.pressed.connect(func():
        RankList.visible = false
        )
    changed.connect(Callable(self,"_change"))

func _change() -> void:
    for nodes in self.get_children():
        nodes.queue_free()
        
    for score in Master._score_list.size():
        var _item = item.instantiate()
        _item.update_ui(score)
        add_child(_item)

func _on_canvas_layer_visibility_changed() -> void:
    changed.emit()
    get_parent().get_parent().visible = get_parent().get_parent().get_parent().visible
