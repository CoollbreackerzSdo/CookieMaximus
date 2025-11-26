extends TextureButton

func _on_pressed() -> void:
	GameManu.is_music_enable = false
	visible = false
