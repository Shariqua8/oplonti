class_name WalkingStateMachine

extends PlayerMovementState

@export var SPEED : float = 6.0
@export var ACCELERATION : float = 0.1
@export var DEACCELERATION : float = 0.3
@export var TOP_ANIM_SPEED : float = 2.2

func enter() -> void:
	ANIMATION.play("Walking", 0.0, 1.0)

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DEACCELERATION)
	PLAYER.update_velocity()
		
	if Input.is_action_just_pressed("crounch") and PLAYER.is_on_floor():
		transition.emit("CrounchingStateMachine")
	
	if Input.is_action_pressed("spin") and PLAYER.is_on_floor():
		transition.emit("SprintingStateMachine")
		
	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		transition.emit("JumpingStateMachine")
	
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdleStateMachine")

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
	
	#
	#if event.is_action_pressed("ui_accept") and Global.player.is_on_floor():
		#transition.emit("JumpingStateMachine")
