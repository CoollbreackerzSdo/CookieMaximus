extends CanvasLayer

signal continue_signal
signal go_to_signal(route: String)
signal restart_signal
signal disabke_effect
signal disable_music
signal enable_effect
signal enable_music


@export var route: String

#var key_efect: Resource = load("res://resources/assets/ui/elements/buttoms/efects_16x16.png")

func _ready() -> void:
	visible = false
	if !GameManu.is_music_enable:
		$BlurEffect/Control/Panel/M.visible = false
		$BlurEffect/Control/Panel/MD.visible = true
	else:
		$BlurEffect/Control/Panel/MD.visible = false
		$BlurEffect/Control/Panel/M.visible = true
	if !GameManu.is_effect_enable:
		$BlurEffect/Control/Panel/E.visible = false
		$BlurEffect/Control/Panel/ED.visible = true
	else:
		$BlurEffect/Control/Panel/ED.visible = false
		$BlurEffect/Control/Panel/E.visible = true

func _on_r_pressed() -> void:
	if GameManu.is_effect_enable:
		$Touch.play()
		await $Touch.finished
		emit_signal("restart_signal")
		return
	emit_signal("restart_signal")


func _on_c_pressed() -> void:
	if GameManu.is_effect_enable:
		$Touch.play()
		emit_signal("continue_signal")
		await $Touch.finished
		return 
	emit_signal("continue_signal")


func _on_h_pressed() -> void:
	if GameManu.is_effect_enable:
		$Touch.play()
		await $Touch.finished
		emit_signal("go_to_signal",route)
		return 
	emit_signal("go_to_signal",route)


func _on_effect_pressed() -> void:
	$Touch.play()
	await $Touch.finished
	$BlurEffect/Control/Panel/E.visible = false
	$BlurEffect/Control/Panel/ED.visible = true
	GameManu.is_effect_enable = false
	emit_signal("disabke_effect")


func _on_music_pressed() -> void:
	$Touch.play()
	await $Touch.finished
	$BlurEffect/Control/Panel/M.visible = false
	$BlurEffect/Control/Panel/MD.visible = true
	GameManu.is_music_enable = false
	emit_signal("disable_music")


func _on_effect_disable_pressed() -> void:
	$Touch.play()
	await $Touch.finished
	$BlurEffect/Control/Panel/ED.visible = false
	$BlurEffect/Control/Panel/E.visible = true
	GameManu.is_effect_enable = true
	emit_signal("enable_effect")

func _on_music_disable_pressed() -> void:
	$Touch.play()
	await $Touch.finished
	$BlurEffect/Control/Panel/MD.visible = false
	$BlurEffect/Control/Panel/M.visible = true
	GameManu.is_music_enable = true
	emit_signal("enable_music")
