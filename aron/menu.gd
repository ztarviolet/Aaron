extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Nombre.load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if Nombre.nivel == 0:
		get_tree().change_scene_to_file("res://esena.tscn")
	else:
		get_tree().change_scene_to_file("res://nivel_1.tscn")
	
