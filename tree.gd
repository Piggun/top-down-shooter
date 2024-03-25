extends StaticBody2D

@onready var anim = %Leaves

func hit():
	anim.show()
	anim.play("start")
	await get_tree().create_timer(2).timeout
	anim.hide()
