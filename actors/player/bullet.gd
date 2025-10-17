extends CharacterBody2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.ZERO

func _ready():
	rotation = direction.angle() + PI/2
	add_to_group("bullet")


func _physics_process(_delta):
	if direction == Vector2.ZERO:
		return
	velocity = direction * speed
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		queue_free()
