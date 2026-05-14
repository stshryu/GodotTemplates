extends Control

func _on_button_pressed() -> void:
	var scene_manager: SceneManager = Utils.get_scene_manager()
	scene_manager.load_scene("other_scene")
