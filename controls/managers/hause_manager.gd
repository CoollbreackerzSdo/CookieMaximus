extends Node2D

class_name HauseManager

@onready var game_menu: GameBasicMenu = $GameBasicMenu
@onready var player: PlayerControl = $Player
@onready var enemy: CookieMonsterControl = $Enemy

func _ready() -> void:
	game_menu.player_info = player.player_detail
	enemy.player = player


func _on_crash_old_chras_optain_signal() -> void:
	player.crash_old_enable = true
	player.crash_old_level+=1


func enable_tools() -> void:
	if player.crash_old_enable:
		$CharOldCursor.visible	= true

func disable_tools() -> void:
	if player.crash_old_enable:
		$CharOldCursor.visible	= false

func pause_signal() -> void:
	$PauseMenu.visible = true
	player.pause_event()

func restart_signal() -> void:
	get_tree().reload_current_scene()

func continue_signal() -> void:
	$PauseMenu.visible = false
	game_menu.continue_evet()
	player.continue_event()

func go_to_signal(_route: String) -> void:
	get_tree().change_scene_to_file("res://resources/godot/scenes/menus/game_main_menu.tscn")


func _on_smook_area_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		$Player/PointLight2D.texture_scale = 0.1
		$Player/PointLight2D.height = 20


func _on_smook_area_body_exited(body: Node2D) -> void:
	if body is PlayerControl:
		$Player/PointLight2D.texture_scale = 0.7
		$Player/PointLight2D.height = 100
