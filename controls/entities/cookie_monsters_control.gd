extends CharacterBody2D

class_name CookieMonsterControl

signal char_collition(damage:int)
@export var speed: float
#@export var min_distance: float = 5.0
@export var damage: int
@export var damage_ticks: float
@export var tps: Array[Marker2D]
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var animations: AnimatedSprite2D = $Sprite
var is_active: bool = false
var player: PlayerControl

func _ready() -> void:
	$DamageTimer.wait_time = damage_ticks
	$AgentTimer.start()

func _physics_process(_delta: float) -> void:
	if is_active == false:
		return
	_agentSearch()
	move_and_slide()

func  _agentSearch() -> void:
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity = direction * speed
	animated_move(velocity)

func _on_collition_char_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		if GameManu.is_effect_enable:
			$Damage.play()
		emit_signal("char_collition",damage)
		$DamageTimer.start()

func _on_agent_timer_timeout() -> void:
	agent.target_position = player.position

func animated_move(axis:Vector2) -> void:
	if axis == Vector2.ZERO:
		return
	if axis.y < 0 && axis.x > 0:
		animations.play("up_rigth")
		return
	if axis.y < 0 && axis.x < 0:
		animations.play("up_left")
		return
	if axis.y > 0 && axis.x > 0:
		animations.play("down_rigth")
		return
	if axis.y > 0 && axis.x < 0:
		animations.play("down_left")
		return
	if axis.y < 0:
		animations.play("up")
		return
	if axis.y > 0:
		animations.play("down")
		return
	if axis.x < 0:
		animations.play("left")
		return
	if axis.x > 0:
		animations.play("rigth")
		return


func _on_damage_timer_timeout() -> void:
	if !is_active:
		$DamageTimer.stop()
		return
	if GameManu.is_effect_enable:
			$Damage.play()
	emit_signal("char_collition",damage)
	await $Damage.finished


func _on_collition_char_body_exited(body: Node2D) -> void:
	$DamageTimer.stop()
