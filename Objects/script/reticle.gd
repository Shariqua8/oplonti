extends CenterContainer

# Sono variabili settabili nell'ispettore (per questo usiamo @export)
# Servono per definire alcune caratteristiche del Reticolo

@export var RETICLE_LINES : Array[Line2D]
@export var PLAYER_CONTROLLER : CharacterBody3D
@export var RETICLE_SPEED : float = 0.15
@export var RETICLE_DISTANCE : float = 2
@export var DOT_RADIUS : float = 1.0
@export var DOT_COLOR : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	# Richiama la funzione queue_redraw() senza passare parametri
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.debug.add_debug_property("ReticleColor", DOT_COLOR, 3) # Aggiunge una proprietà Reticle Color
	
	_adjust_reticle_lines()

func _draw():
	# La funzione draw_circle, disegna un cerchio di centro 0, 0 (lo specifichiamo con Vector2. DOT_RADIUS è il raggio, mentre DOT_COLOR è il colore del cerchio.
	# Disegna un punto
	draw_circle(Vector2(0,0), DOT_RADIUS, DOT_COLOR)

# Non necessario, serviva per gestire il CrossHair in modo differente
func _adjust_reticle_lines():
	var vel = PLAYER_CONTROLLER.get_real_velocity()
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = origin.distance_to(vel)
	
	# Cambio del CROSSHAIR a seconda del movimento
	RETICLE_LINES[0].position = lerp(RETICLE_LINES[0].position, pos + Vector2(0, -speed * RETICLE_DISTANCE), RETICLE_SPEED)	#TOP
	RETICLE_LINES[1].position = lerp(RETICLE_LINES[1].position, pos + Vector2(speed * RETICLE_DISTANCE, 0), RETICLE_SPEED)	#RIGHT
	RETICLE_LINES[2].position = lerp(RETICLE_LINES[2].position, pos + Vector2(0, speed * RETICLE_DISTANCE), RETICLE_SPEED)	#BOTTOM
	RETICLE_LINES[3].position = lerp(RETICLE_LINES[3].position, pos + Vector2(-speed * RETICLE_DISTANCE, 0), RETICLE_SPEED)	#LEFT
	
	
	
