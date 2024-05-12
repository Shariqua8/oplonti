class_name Player

extends CharacterBody3D

@onready var gun_anim = $CameraController/Camera3D/Rifle/AnimationPlayer
@onready var gun_barrell = $CameraController/Camera3D/Rifle/RayCast3D

@export var MOUSE_SENSITIVITY : float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var ANIMATIONPLAYER : AnimationPlayer
@export var CROUCH_SHAPECAST : Node3D
@export var ACCELERATION :float = 0.1
@export var DEACCELERATION : float = 0.3	
# @export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLER : float = 0.85

var _mouse_input : bool = false
var _rotation_input : float
var _speed : float
var _tilt_input : float
var _mouse_rotation : Vector3
var _player_rotation : Vector3
var _camera_rotation : Vector3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 8.0

var bullet = load("res://Objects/prefab/Bullet_test.tscn")
var instance

# Gestiamo il tasto ESC per uscire dal Gioco
func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()


func _unhandled_input(event: InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func update_camera(delta) -> void:
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)

	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	CAMERA_CONTROLLER.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0

# Prendiamo i movimenti del mouse
func _ready():
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	Global.player = self
	
	Global.debug.add_debug_property("MouseRotation", _mouse_rotation , 2)	
	Global.debug.add_debug_property("Velocity","%.2f" % velocity.length(), 1)
	
	#Aggiungiamo la gravità
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	update_camera(delta)

	# Gestiamo il salto, quando è premuto il tasto SPACE
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("shoot"):
		if !gun_anim.is_playing():
			gun_anim.play("shoot")
			instance = bullet.instantiate()
			instance.position = gun_barrell.global_position
			instance.transform.basis = gun_barrell.global_transform.basis
			get_parent().add_child(instance)

func update_gravity(delta) -> void:
	velocity.y -= gravity * delta


func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir = Input.get_vector("player_move_left", "player_move_right", "player_move_up", "player_move_down")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x,direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z,direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
func update_velocity() -> void:
	move_and_slide()
