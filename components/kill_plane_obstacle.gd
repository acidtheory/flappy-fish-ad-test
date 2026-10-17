extends Area2D


func _on_area_entered(area):
	area.get_parent().position = Vector2(2000,randf_range(512,1152))
