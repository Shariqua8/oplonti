class_name SprintingStateMachine 

extends PlayerMovementState

@export var SPEED : float = 12.0
@export var ACCELERATION : float = 0.1
@export var DEACCELERATION : float = 0.3
@export var TOP_ANIM_SPEED : float = 1.6

func enter() -> void:
	ANIMATION.play("Sprinting", 0.5, 0.8)


func update(delta : float):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DEACCELERATION)
	PLAYER.update_velocity()
	
	set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		transition.emit("JumpingStateMachine")
	
	if Input.is_action_just_released("spin"):
		transition.emit("WalkingStateMachine")

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, -1.0, 1.2)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
