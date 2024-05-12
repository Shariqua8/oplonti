class_name JumpingStateMachine

extends PlayerMovementState

# Variabile per segnalare lo stato
@export var SPEED : float = 6.0
@export var ACCELERATION :float = 0.1
@export var DEACCELERATION : float = 0.3	
@export var JUMP_VELOCITY : int = 5
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLER : float = 0.85
	
# Called when the node enters the scene tree for the first time.
func enter() -> void:
	PLAYER.velocity.y += JUMP_VELOCITY
	ANIMATION.pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULTIPLER, ACCELERATION, DEACCELERATION)
	PLAYER.update_velocity()
		
	if PLAYER.is_on_floor():
		transition.emit("IdleStateMachine")
