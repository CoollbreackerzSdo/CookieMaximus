extends CanvasLayer

class_name GameBasicMenu

signal pause_signal

@onready var time_label: Label = $Base/Panel/TImeLabel
@onready var heatl_bar: TextureProgressBar = $Base/Margin/Container/Info/Healt
@onready var stress_bar: TextureProgressBar = $Base/Margin/Container/Info/Stress
@onready var hungry_bar: TextureProgressBar = $Base/Margin/Container/Info/Hungry
@onready var control: Control = $Base

var player_info: PlayerDetail
var curren_time = 0
var is_pause:= false
var current_s: int
var current_m: int 

func _ready() -> void:
	control.mouse_filter = Control.MOUSE_FILTER_IGNORE

func  _enter_tree() -> void:
	if player_info == null:
		player_info = PlayerDetail.create(100,20,10)

func _process(delta: float) -> void:
	if !is_pause:
		curren_time += delta
		heatl_bar.value = player_info.healt
		stress_bar.value = player_info.stress
		hungry_bar.value = player_info.hungry
		time_label.text = get_time(0)

func get_time(format: int) -> String:
	var minutos = int(curren_time) / 60
	current_m = minutos
	var segundos = int(curren_time) % 60
	current_s = segundos
	if format == 0:
		return str(minutos).pad_zeros(2) + ":" + str(segundos).pad_zeros(2)
	else:
		return str(minutos).pad_zeros(2) + ":m" + str(segundos).pad_zeros(2) + "s"

func restart_evet() -> void:
	curren_time = 0
	is_pause = false
	visible = true

func continue_evet() -> void:
	is_pause = false
	visible = true

func _on_pause_pressed() -> void:
	if GameManu.is_effect_enable:
		$Touch.play()
		is_pause = true
		visible = false
		await $Touch.finished
		emit_signal("pause_signal")
		return
	is_pause = true
	visible = false
	emit_signal("pause_signal")
