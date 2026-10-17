extends Area2D

@onready var main_game: MainGame = $".."

func _on_body_entered(_body):
	main_game.die()
