extends PanelContainer

@onready var property_container = %VBoxContainer	# quando è pronto la variabile property_container prenderà il valore di VBoxContainer

#var property
var frames_per_second : String

# Called when the node enters the scene tree for the first time.
func _ready():
	#Imposta le referenze per se stesso nel Global
	Global.debug = self
	
	#Nascondere debug Panel
	visible = false
	
	#add_debug_property("FPS", frames_per_second)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		# Usiamo il delta per ottenere una misurazione approssimativa
		frames_per_second = "%.2f" % (1.0 / delta) # Otteniamo gli FPS facendo 1.0/delta (delta è di ogni seconod)
		#property.text = property.name + ": " + frames_per_second # Formattazione testo

func _input(event):
	# Rimuove/aggiunge il pannello di Debug
	if event.is_action_pressed("debug"):
		visible = !visible

func add_debug_property(title : String, value, order):
	var target
	target = property_container.find_child(title, true, false) # Trova un label con lo stesso nome
	if !target:
		target = Label.new() # Crea un nuovo Label
		property_container.add_child(target) # Aggiunge un child per il property_container (con il nome del target)
		target.name = title	# Il nome del target prendere il valore contenuto in title
		target.text = target.name + ": " + str(value)	# Formatta il testo
	elif visible:
		target.text = title + ": " + str(value) # Formatta il testo
		property_container.move_child(target, order) # Muove il child target a seconda dell'ordine
	
# Funzione chiamabile per aggiungere nuove proprietà al Debug Panel
#func add_debug_property(title : String, value):
	#property = Label.new()	# Crea un nuovo Label
	#property_container.add_child(property)	# Aggiunge nuovi nodi come figli nel VBox (per essere visualizzate le proprietà)
	#property.name = title	# Imposta il nuovo nome
	#property.text = property.name + value
	


