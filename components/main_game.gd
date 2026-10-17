extends Control
class_name MainGame

var game_speed : float = 5


signal has_died

@onready var player: Player = $Player
@onready var ad_manager: AdManager = $AdManager

func _ready() -> void:
	ad_manager.create_banner_ad(AdPosition.BOTTOM)

func _physics_process(delta: float) -> void:
	if not player.dead:
		game_speed += delta * 0.5

@onready var death_label: Label = $DeathScreen/CenterContainer/VBoxContainer/DeathLabel
@onready var death_screen: Control = $DeathScreen
func die():
	death_label.text = "TE MORISTE PAPIRRI\nTU SCORE FUE %s" % score
	death_screen.show()
	has_died.emit()

@onready var obstacle: Obstacle = $Obstacle
@onready var obstacle_2: Obstacle = $Obstacle2

func _restart():
	game_speed = 5
	player.position = Vector2(540,960)
	player.velocity.y = 0
	obstacle.position.x = 2000
	obstacle_2.position.x = 3000
	death_screen.hide()
	player.dead = false
	score = 0

func _watch_ad_and_continue():
	await ad_manager.create_reward_ad()
	print("hola")
	player.position = Vector2(540,960)
	player.velocity.y = 0
	obstacle.position.x = 2000
	obstacle_2.position.x = 3000
	death_screen.hide()
	player.dead = false


var score : int = 0:
	set(value):
		score_counter.text = str(value)
		score = value

@onready var score_counter: Label = $ScoreCounterContainer/ScoreCounter
