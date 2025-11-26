extends Sprite2D

class_name  CharOldCursorControl

func _enter_tree() -> void:
	visible = false

func _process(delta: float) -> void:
	position = get_global_mouse_position() 
