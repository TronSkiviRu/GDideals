extends CharacterBody2D

@export var bullet_scene: PackedScene # PackedScene - упакованная сцена на созд.
@export var fire_rate: float = 0.2 # Частота выстрелов
@export var speed: int = 300

var last_movement_direction: Vector2 = Vector2.UP
var input_direction: Vector2 = Vector2.ZERO
var can_shoot: bool = true
var shoot_pressed: bool = false # флаг для стрельбы


func _process(_delta):
	# сам нормализует и при отсутствии хранит ZERO
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	
	if input_direction != Vector2.ZERO:
		last_movement_direction = input_direction
		
	shoot_pressed = Input.is_action_pressed("ui_accept")
	
func _physics_process(_delta: float) -> void:
	
	velocity = input_direction * speed
	move_and_slide()
	
	if shoot_pressed and can_shoot:
		shoot()
		can_shoot = false
		# Таймер на выстрел; он одноразовый и уничтожается после срабатывания
		get_tree().create_timer(fire_rate).timeout.connect(_on_shoot_sooldown)		

func _ready():
	add_to_group("player")
	
 
	
func shoot():
	var bullet = bullet_scene.instantiate() # Создаем пулю
	bullet.global_position = global_position #+ Vector2(0, -90) # позиция рядом с игроком
	bullet.direction = last_movement_direction # Даем направление пуле
	get_parent().add_child(bullet) # Добавление в дерево сцены

func _on_shoot_sooldown():
	can_shoot = true
