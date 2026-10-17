extends Node2D
class_name Obstacle

@onready var main_game: MainGame = $".."

func _physics_process(delta: float) -> void:
	position.x -= main_game.game_speed * (delta * 60)

func _on_player_touch_obstacle(_body):
	main_game.die()

func _on_player_touch_score_upper(_body):
	main_game.score += 1
