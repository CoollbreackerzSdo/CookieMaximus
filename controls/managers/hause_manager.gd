extends Node2D

class_name HauseManager

@onready var game_menu: GameBasicMenu = $GameBasicMenu
@onready var player: PlayerControl = $Player
@onready var enemy: CookieMonsterControl = $Enemy

func _ready() -> void:
	game_menu.player_info = player.player_detail
	enemy.player = player


func _on_crash_old_chras_optain_signal(level: int) -> void:
	if player.crash_old_enable == false:
		player.crash_old_enable = true
	player.add_tool_level(level)
	if player.crash_old_level >= 4:
		$Enemy.is_active = true

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


func _on_zone_1_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		body.is_secure_zone = true
		$Enemy.is_active = false
		$Enemy.position = $Enemy.tps[randi_range(0,3)].position


func _on_zone_1_body_exited(body: Node2D) -> void:
	if body is PlayerControl:
		body.is_secure_zone = false
		$Enemy.is_active = true


func _on_wining_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		$Music.stop()
		$Enemy.is_active = false
		player.pause_event()
		$GameBasicMenu.visible = false
		await $WindMenu.play_animation()


func _on_player_dead_signal() -> void:
	$Enemy.is_active = false
	$"Dead Menu".game_time = str($GameBasicMenu.current_m) + "m:" +  str($GameBasicMenu.current_s) + "s"
	$"Dead Menu".visible = true


func _on_limit_zone_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		$Music.stop()
		$WindMusic.play()
		$Player/PointLight2D.texture_scale = 0.5
		$Player/PointLight2D.energy = 1.5
