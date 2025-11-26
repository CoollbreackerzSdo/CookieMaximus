extends TextureButton


func _on_pressed() -> void:
	GameManu.is_music_enable = true
	visible = false
