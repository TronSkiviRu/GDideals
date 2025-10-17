extends CharacterBody2D

@export var health: int = 3
@export var speed: int = 80

var player: Node2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")
	$Area2D.body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	

func _on_body_entered(area: Node2D):
	if area.is_in_group("bullet"):
		take_damage(1)
		area.queue_free()


func take_damage(amount: int):
	health -= amount
	
	if health <= 0:
		die()

func die():
	queue_free()
