extends Node

const FADE_SCENE = preload("res://scenes/ui/fade/fade_transition.tscn")

var fade

func change_scene(path: String):
	fade = FADE_SCENE.instantiate()
	get_tree().root.add_child(fade)

	fade.fade_in()
	await fade.fade_finished

	get_tree().change_scene_to_file(path)

	fade.fade_out()
