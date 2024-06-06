extends RigidBody3D

var is_visible_on_screen : bool = false

func _on_body_entered(body: Node) -> void:
	if(body.name == "Player"):
		SignalBus.game_over.emit()

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	is_visible_on_screen = true

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	is_visible_on_screen = false
