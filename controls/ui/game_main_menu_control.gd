extends Node2D

class_name GameManu

static var is_effect_enable: bool = true
static var is_music_enable: bool = true 
@onready var music_activator: TextureButton = $Menu/Control/MarginContainer/Control/MusicActivator
@onready var music_des_activator: TextureButton = $Menu/Control/MarginContainer/Control/MusicDesActivator

func _ready() -> void:
	if is_music_enable:
		music_activator.visible = true
		music_des_activator.visible = false

func _on_music_des_activator_pressed() -> void:
	$Music.play()
	is_music_enable = true
	music_activator.visible = true

func _on_music_activator_pressed() -> void:
	$Music.stop()
	is_music_enable = false
	music_des_activator.visible = true


func _on_play_pressed() -> void:
	if is_effect_enable:
		$Touch.play()
		await $Touch.finished 
	get_tree().change_scene_to_file("res://resources/godot/scenes/levels/hause.tscn")
