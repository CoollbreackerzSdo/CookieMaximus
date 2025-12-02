extends CharacterBody2D

class_name CookieMonsterControl

signal char_collition(damage:int)
@export var speed: float
@export var min_distance: float = 5.0
@export var damage: int
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var animations: AnimatedSprite2D = $Sprite
var player: PlayerControl

func _ready() -> void:
	$AgentTimer.start()

func _physics_process(_delta: float) -> void:
	#if search_mode == CookieMonsterState.SearchMode.Navigation && player != null:
	_agentSearch()
	#elif search_mode == CookieMonsterState.SearchMode.Weapoint:
		#_WeapointSearch()
		
	move_and_slide()

func  _agentSearch() -> void:
	var direction = to_local(agent.get_next_path_position()).normalized()
	velocity = direction * speed
	animated_move(velocity)

func _on_timer_timeout() -> void:
	$Timer.stop()

func _on_collition_char_body_entered(body: Node2D) -> void:
	if body is PlayerControl:
		#search_mode = CookieMonsterState.SearchMode.Navigation
		#$Timer.stop()
		#$PlayerFocus.start()
		emit_signal("char_collition",damage)

func _on_agent_timer_timeout() -> void:
	agent.target_position = player.position

func _on_player_focus_timeout() -> void:
	#search_mode = CookieMonsterState.SearchMode.Weapoint
	$AgentTimer.stop()

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
