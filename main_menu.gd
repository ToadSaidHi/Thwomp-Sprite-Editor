extends Node2D


func _on_new_project_button_up() -> void:
	get_tree().change_scene_to_file("res://Project Manipulation/newProject.tscn")
