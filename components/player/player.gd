extends CharacterBody2D
class_name Player

var jump_force : float = -750
var dead : bool = false
@onready var main_game: MainGame = $".."

func _physics_process(delta: float) -> void:
	if not dead:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
	velocity += get_gravity() * delta
	move_and_slide()
	rotation = move_toward(rotation,velocity.y / 1000, delta * 10)

func _ready() -> void:
	main_game.has_died.connect(_die)

func _die():
	velocity.y = 1000
	dead = true
