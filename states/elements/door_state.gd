extends StaticBody2D

class_name  DoorState

@export var tool_requeriment_levet: int = 0

func _on_top_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		if body.crash_old_level >= tool_requeriment_levet:
			queue_free()

func _on_botton_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		if body.crash_old_level >= tool_requeriment_levet:
			queue_free()
