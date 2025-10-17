# Node - базовый класс для ЛЮБОГО объекта в Godot
# Node2D - только для 2D объектов (имеет позицию, rotation)
# GameManager - это логика, а не визуальный объект, поэтому Node
extends Node

# Сигналы - это система СОБЫТИЙ в Godot
# Объявляем, что наш GameManager может "кричать" о некоторых событиях
# Другие объекты могут "подписаться" на эти крики

# Сигнал "началась волна" с параметром номера волны
signal wave_started(wave_number)
# Сигнал "волна пройдена" 
signal wave_cleared(wave_number)
# Сигнал "очки изменились"
signal score_changed(new_score)

var current_wave: int = 0
var player_score: int = 0
var enemies_alive: int = 0

var wave_manager: WaveManager # создаем экземпляр

func _ready():
	wave_manager = WaveManager.new()

func start_new_wave():
	current_wave += 1
	var wave_config = wave_manager.get_wave_config(current_wave)
	enemies_alive = wave_config["enemy_count"]
	wave_started.emit(current_wave) # сигналим подписчикам о новом лвл
	spawn_enemies(wave_config)
	
func on_enemy_died():
	enemies_alive -= 1
	player_score += 100 * current_wave # реализация получения очков
	score_changed.emit(player_score) # Сигналим
	
	if enemies_alive <= 0:
		wave_cleared.emit(current_wave) #сигналим о конце волны
		await get_tree().create_timer(3.0).timeout
		start_new_wave()
	
	
func spawn_enemies(wave_config: Dictionary):
	print()
	print("=== ВОЛНА ", current_wave, " ===")
	print("Врагов: ", wave_config["enemy_count"])
	print("Тип: ", wave_config["enemy_type"])
	print("Скорость спавна: ", wave_config["enemy_rate"])
	print()
	# ниже логика спавна врагов
 
