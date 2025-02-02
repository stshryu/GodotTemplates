extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var mobhealthbar = %HealthBar

@export var mob_speed = 50
@export var default_health = 200.0
@export var damage_rate = 5.0

var current_health = default_health

func _ready():
	mobhealthbar.max_value = default_health
	mobhealthbar.value = default_health
	#%DebugHealthText.text = str(current_health) + "/" + str(default_health)

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()

func take_damage(amount: float):
	current_health -= amount
	mobhealthbar.value = current_health
	#%DebugHealthText.text = str(int(current_health)) + "/" + str(int(default_health)) + "\n"
	#%DebugHealthText.append_text("Last hit: " + str(int(amount)))
	if current_health <= 0.0:
		queue_free()
