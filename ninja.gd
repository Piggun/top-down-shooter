extends CharacterBody2D

@onready var player = get_node("/root/Game/player")
@onready var anim = %Ninja

var health = 3

func _ready():
	anim.play("walk")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		queue_free()
		const ninja_dead = preload("res://ninja-dead.tscn")
		var new_ninja_dead = ninja_dead.instantiate()
		get_parent().add_child(new_ninja_dead)
		new_ninja_dead.global_position = global_position
	anim.play("hurt")
	await get_tree().create_timer(0.2).timeout
	anim.play("walk")

