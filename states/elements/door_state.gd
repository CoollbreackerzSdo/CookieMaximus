extends StaticBody2D

class_name  DoorState

signal top_collition_signal
signal bottom_collition_signal
signal mause_entered
signal mause_exited
signal collition_body_signal

@export var tool_requeriment_levet: int = 0
var body_tool_level: int
var is_body_entered: bool = false
var is_maouse_entered: bool = false

func _on_top_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		is_body_entered = true
		emit_signal("top_collition_signal")
		emit_signal("collition_body_signal")
		body_tool_level = body.crash_old_level
 
func _input(event: InputEvent) -> void:
	if body_tool_level >= tool_requeriment_levet && is_body_entered:
		emit_signal("mause_exited")
		queue_free()

func _on_botton_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		
		is_body_entered = true
		emit_signal("bottom_collition_signal")
		emit_signal("collition_body_signal")

func mouse_entered() -> void:
	emit_signal("mause_entered")
	is_maouse_entered =	true

func mouse_exited() -> void:
	emit_signal("mause_exited")
	is_maouse_entered = false

func _on_top_body_exited(body: Node2D) -> void:
	if body is PlayerControl:
		is_body_entered = false

func _on_botton_body_exited(body: Node2D) -> void:
	if body is PlayerControl:
		is_body_entered = false
