extends Node2D

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://word.tscn")

func _on_how_to_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://howtoplay.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
