extends Panel

class_name  KeyInputState

var key_up_normal_texture: Texture2D = load("res://resources/assets/ui/elements/keys/w_13x14.png")
var key_up_normal_hover_texture: Texture2D = load("res://resources/assets/ui/elements/keys/w_hover_13x14.png")

var key_down_normal_texture: Texture2D = load("res://resources/assets/ui/elements/keys/s_13x14.png")
var key_down_normal_hover_texture: Texture2D = load("res://resources/assets/ui/elements/keys/s_hover_13x14.png")

var key_rigth_normal_texture: Texture2D = load("res://resources/assets/ui/elements/keys/d_13x14.png")
var key_rigth_normal_hover_texture: Texture2D = load("res://resources/assets/ui/elements/keys/d_hover_13x14.png")

var key_left_normal_texture: Texture2D = load("res://resources/assets/ui/elements/keys/a_hover_13x14.png") 
var key_left_normal_hover_texture: Texture2D = load("res://resources/assets/ui/elements/keys/a_13x14.png")

#var key_interactivity_normal_texture: Texture2D = load("res://resources/assets/ui/elements/keys/q_hover_13x14.png")
#var key_interactivity_normal_hover_texture: Texture2D = load("res://resources/assets/ui/elements/keys/q_14x14.png")

@onready var w_key_sprite: Sprite2D = $W
@onready var s_key_sprite: Sprite2D = $S
@onready var a_key_sprite: Sprite2D = $A
@onready var d_key_sprite: Sprite2D = $D
@onready var q_key_sprite: Sprite2D = $Q

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		w_key_sprite.texture = key_up_normal_hover_texture
	else: w_key_sprite.texture = key_up_normal_texture  
	if event.is_action_pressed("ui_down"):
		s_key_sprite.texture = key_down_normal_hover_texture
	else: s_key_sprite.texture = key_down_normal_texture  
	if event.is_action_pressed("ui_right"):
		d_key_sprite.texture = key_rigth_normal_hover_texture
	else: d_key_sprite.texture = key_rigth_normal_texture 
	if event.is_action_pressed("ui_left"):
		a_key_sprite.texture = key_left_normal_texture
	else: a_key_sprite.texture = key_left_normal_hover_texture   
	#if event.is_action_pressed("ui_interactive"):
		#q_key_sprite.texture = key_interactivity_normal_texture
	#else: q_key_sprite.texture = key_interactivity_normal_hover_texture
