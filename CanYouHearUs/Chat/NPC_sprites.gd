extends CanvasLayer

func PlayAnimacion():
	$AnimationPlayer.play("Loop")
func DetenerAnimacion():
	$AnimationPlayer.stop()

func _ready():
	show()
