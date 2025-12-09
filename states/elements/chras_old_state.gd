extends Area2D

class_name CrarsOldState

signal chras_optain_signal(level: int)
@export var level: int
@onready var audio:AudioStreamPlayer2D = $Audio

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		if GameManu.is_effect_enable:
			audio.play()
		emit_signal("chras_optain_signal",level)
		await audio.finished
		queue_free()
