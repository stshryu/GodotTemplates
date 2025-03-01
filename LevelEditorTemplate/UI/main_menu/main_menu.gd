extends Control

func _on_button_pressed():
	var scene_manager = Utils.get_scene_manager()
	scene_manager.load_scene("level_editor")
