extends CharacterBody2D

class_name  PlayerControl

signal dead_signal
@onready var animations: AnimatedSprite2D = $Sprite
@export var speed: float
@export var steps_effects: AudioStream
@export var hungry_increase: int
@export var stress_increase: int
var crash_old_enable: bool = false
var crash_old_level: int = 0
var is_pause: bool = false
var is_secure_zone: bool = false
var player_detail: PlayerDetail

func _enter_tree() -> void:
	player_detail = PlayerDetail.create(100)

func _physics_process(_delta: float) -> void:
	if is_pause: return 
	update_status()
	var axis = get_move()
	velocity = axis * speed 
	move_and_slide()
	animated_move(axis)

func get_move() -> Vector2:
	return Input.get_vector("ui_left","ui_right","ui_up","ui_down")

func animated_move(axis:Vector2) -> void:
	if axis == Vector2.ZERO:
		return
	$Steps.play()
	if axis.y < 0 && axis.x > 0:
		animations.play("up_rigth")
		await $Steps.finished
		return
	if axis.y < 0 && axis.x < 0:
		animations.play("up_left")
		await $Steps.finished
		return
	if axis.y > 0 && axis.x > 0:
		animations.play("down_rigth")
		await $Steps.finished
		return
	if axis.y > 0 && axis.x < 0:
		animations.play("down_left")
		await $Steps.finished
		return
	if axis.y < 0:
		animations.play("up")
		await $Steps.finished
		return
	if axis.y > 0:
		animations.play("down")
		await $Steps.finished
		return
	if axis.x < 0:
		animations.play("left")
		await $Steps.finished
		return
	if axis.x > 0:
		animations.play("rigth")
		await $Steps.finished
		return

func pause_event() -> void:
	is_pause = true

func continue_event() -> void:
	is_pause = false

func state() -> void:
	if player_detail.healt <= 0:
		dead_signal.emit()

func update_status() -> void:
	if player_detail.healt==0:
		emit_signal("dead_signal")
		is_pause = true
		return
	if is_secure_zone: return
	
	if player_detail.stress >= 100:
		player_detail.healt -= 10
		player_detail.stress = 0
	if player_detail.hungry >= 100:
		player_detail.healt -=5
		player_detail.hungry = 0
		
func _on_enemy_char_collition(damage: int) -> void:
	player_detail.healt -= damage

func add_tool_level(value: int):
	crash_old_level += value


func _on_area_2d_2_collition_body(value: int) -> void:
	player_detail.hungry-=value


func _on_hungry_timeout() -> void:
	player_detail.hungry += hungry_increase
	if player_detail.hungry >= 100:
		player_detail.hungry = 0
		player_detail.healt -= 10


func _on_stress_timeout() -> void:
	if is_secure_zone:
		return
	player_detail.stress += stress_increase
	if player_detail.stress >= 100:
		player_detail.stress = 0
		player_detail.healt -= 20
