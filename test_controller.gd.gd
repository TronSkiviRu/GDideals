extends Node2D

func _ready():
	# Подписываемся на сигналы GameManager
	GameManager.wave_started.connect(_on_wave_started)
	GameManager.wave_cleared.connect(_on_wave_cleared)
	GameManager.score_changed.connect(_on_score_changed)

func _input(event):
	# По нажатию пробела начинаем волну
	if event.is_action_pressed("ui_accept"):
		GameManager.start_new_wave()
		var test_wave = 7
		var config = GameManager.wave_manager.get_wave_config(test_wave)
		
		print("Конфиг для волны ", test_wave, ": ", config)
	# По нажатию 'D' симулируем смерть врага
	if event.is_action_pressed("ui_down"):
		GameManager.on_enemy_died()

# аргумент в функцию передается от сигнализатора, воу
func _on_wave_started(wave_number):
	print("ВОЛНА НАЧАЛАСЬ: ", wave_number)

func _on_wave_cleared(wave_number):
	print("ВОЛНА ПРОЙДЕНА: ", wave_number)

func _on_score_changed(new_score):
	print("НОВЫЕ ОЧКИ: ", new_score)
