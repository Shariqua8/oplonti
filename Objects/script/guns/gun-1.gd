extends State

# Proprietà dell'arma
var damageAmount : int = 10
var bulletSpeed : float = 50.0

# Nodo del modello animato dell'arma
@onready var weaponModel : AnimatedModel = $WeaponModel

# Nodo dell'animazione del proiettile
@onready var bulletAnimation : AnimatedSprite = $BulletAnimation

func _ready():
	# Inizia nello stato di riposo
	enter()

func _process(delta):
	# Aggiorna la logica della macchina a stati
	update(delta)

func _physics_process(delta):
	# Aggiorna la logica fisica della macchina a stati
	physics_update(delta)

# Funzione per sparare il proiettile
func shoot():
	# Crea il proiettile e lo aggiunge alla scena
	var bullet = bulletAnimation.instance()
	get_parent().add_child(bullet)

	# Imposta la direzione e la velocità del proiettile
	var bulletDirection = $BulletSpawnPoint.global_transform.basis.z.normalized()
	bullet.global_transform.origin = $BulletSpawnPoint.global_transform.origin
	bullet.linear_velocity = bulletDirection * bulletSpeed

	# Cambia lo stato dell'arma a "SHOOTING"
	transition("SHOOTING")
