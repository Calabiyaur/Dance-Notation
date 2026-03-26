extends Node


func switch_to(resource_path: String, params: Callable = func(scene): {}):
	var scene = load(resource_path).instantiate()
	params.call(scene)
	get_tree().get_root().add_child(scene)
	get_tree().get_root().remove_child(get_tree().current_scene)
	get_tree().current_scene = scene
