extends StaticBody2D

@onready var anim = %Leaves

func hit():
	anim.show()
	anim.play("start")


func _on_leaves_animation_finished():
	anim.hide()
