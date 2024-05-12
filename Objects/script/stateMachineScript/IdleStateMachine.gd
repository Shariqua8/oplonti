class_name IdleStateMachine

extends PlayerMovementState

@export var SPEED : float = 6.0
@export var ACCELERATION : float = 0.1
@export var DEACCELERATION : float = 0.3

func enter() -> void:
	ANIMATION.pause()

# Called when the node enters the scene tree for the first time.
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DEACCELERATION)
	PLAYER.update_velocity()
	
	# Verifica se il player si stia muovendo allora emetterà il nuovo stato 
	if PLAYER.velocity.length()>0.0 and PLAYER.is_on_floor():
		transition.emit("WalkingStateMachine")
		
	if Input.is_action_just_pressed("crounch") and PLAYER.is_on_floor():
		transition.emit("CrounchingStateMachine")

	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		transition.emit("JumpingStateMachine")
