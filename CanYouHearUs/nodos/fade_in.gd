extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	play("FadeIn")


func _on_animation_finished(_anim_name):
	queue_free()
