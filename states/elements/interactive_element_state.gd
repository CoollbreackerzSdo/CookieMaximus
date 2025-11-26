extends Area2D

class_name InteractiveCursor
signal click_signal
@onready var animations: AnimatedSprite2D = $Interactive
var is_entered: bool = false

func _ready() -> void:
	animations.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.pressed && is_entered:
		emit_signal("click_signal")

func _on_mouse_entered() -> void:
	animations.visible = true
	animations.play("default")
	is_entered = true

func _on_mouse_exited() -> void:
	animations.visible = false
	animations.stop()
	is_entered = false
