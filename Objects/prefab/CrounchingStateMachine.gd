class_name CrounchingStateMachine extends PlayerMovementState

@export var SPEED : float = 6.0
@export var ACCELERATION : float = 0.1
@export var DEACCELERATION : float = 0.3
@export_range(1, 6, 0.1) var CROUNCH_SPEED : float = 4.0

@onready var CROUNCH_SHAPECAST : ShapeCast3D = $"../../ShapeCast3D"

func enter() -> void:
	ANIMATION.play("Crounching", -1.0 , CROUNCH_SPEED)
	
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DEACCELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("crounch"):
		uncrounch()

func uncrounch():
	if CROUNCH_SHAPECAST.is_colliding() == false and Input.is_action_just_pressed("crounch") == false:
		ANIMATION.play("Crounching", -1.0, -CROUNCH_SPEED * 1.5, true)
		if ANIMATION.is_playing():
			await ANIMATION.animation_finished
		transition.emit("IdleStateMachine")
	elif CROUNCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(1, 0).timeout
		uncrounch()
