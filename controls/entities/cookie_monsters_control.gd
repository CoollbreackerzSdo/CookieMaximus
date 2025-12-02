extends CharacterBody2D

class_name CookieMonsterControl

signal char_collition(damage:int)
@export var weapoins: Array[Marker2D]
@export var speed: float
@export var min_distance: float = 5.0
@export var damage: int
@onready var agent: NavigationAgent2D = $NavigationAgent2D
var player: PlayerControl
var current_weapoins: int = 0
var emotion_state: CookieMonsterState.EmoteStates = CookieMonsterState.EmoteStates.Calm
var search_mode: CookieMonsterState.SearchMode = CookieMonsterState.SearchMode.Weapoint

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

func _WeapointSearch() -> void:
	var weapoins_position: = weapoins[current_weapoins].global_position
	var direction = weapoins_position - global_position
	var current_distance = direction.length()
	direction = direction.normalized()
	velocity = direction * speed
	if current_distance < min_distance:
		current_weapoins+=1
		velocity = Vector2.ZERO
		$Timer.start()
		if current_weapoins >= weapoins.size():
			current_weapoins = 0

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
