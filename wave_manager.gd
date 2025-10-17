extends Node

# даст скрипту имя класса, позволит создавать его экземпляры и 
# обращаться к нему как к типу
class_name WaveManager
# словарь, хранит инфу об волнах
var wave_configs = {
	1: {"enemy_count": 5, "enemy_type": "basic", "enemy_rate": 1.0},
	3: {"enemy_count": 8, "enemy_type": "basic", "enemy_rate": 0.8},
	5: {"enemy_count": 12, "enemy_type": "fast", "enemy_rate": 0.6},
	10: {"enemy_count": 15, "enemy_type": ["basic", "fast", "tank"], "enemy_rate": 0.5}
}

func get_wave_config(wave_number: int) -> Dictionary:
	var config_keys = wave_configs.keys() #получение всех ключей
	config_keys.sort() # сортируем ключи по возрастанию
	# ищем подходящую конфигурацию
	var t = 1
	for key in config_keys:
		if key > wave_number:  # если волна меньше или равна нашей
			break
		else:
			t = key
	# все что выше 10 волны
	return wave_configs[t]
	
func get_random_enemy_type(enemy_type_config):
	# есть идея лучше, вызывать несколько типов, а не 1 рандомный!
	pass
		
