extends Node2D


func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_recipes_pressed():
	$Panel.visible = !$Panel.visible


func _on_guide_pressed():
	$Panel2.visible = !$Panel2.visible
