extends Node


var GameRunning = false
var deaths:int = 0

var waveNumber:int = 0

var LastScore:int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameRunning:
		_spawnEnemies(delta)
	



var waveEnemiesRemaining:int = 0
var baseWaveEnemies:int = 10

var enemySpawnTimer:float = 0
var enemySpawnFrequency: float
var baseEnemyFrequency:float = .8

var betweenWaveTimer:float = 0
var betweenWavePause:float = 1.5

func _spawnEnemies(delta: float):
	if waveEnemiesRemaining > 0:
		enemySpawnTimer += delta
		if enemySpawnTimer >= enemySpawnFrequency:
			enemySpawnTimer = 0
			_spawnEnemy()
	if NumEnemies() <= 0 and waveEnemiesRemaining <= 0:
		betweenWaveTimer+=delta
	if betweenWaveTimer >= betweenWavePause:
		#new wave graphic
		waveNumber+=1
		_startWave(baseWaveEnemies * waveNumber, baseEnemyFrequency / waveNumber)
		betweenWaveTimer = 0

func _startWave(enemies: int, frequency: float):
	waveNumber += 1
	waveEnemiesRemaining = enemies
	enemySpawnFrequency = frequency

func StartGame():
	GameRunning = true
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	waveNumber =0
	_startWave(baseWaveEnemies, baseEnemyFrequency)
	

func PlayerDeath():
	LastScore = Player.Instance.score
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
	deaths+=1
	GameRunning = false
	
func _spawnEnemy():
	var enemy = preload("res://Prefabs/Enemy.tscn").instantiate()
	var randx:float = randf_range(0,1) - .5
	var randy:float = randf_range(0,1) - .5
	var rand:Vector2 = Vector2(randx,randy).normalized()
	var distx:int = randi_range(950, 1100)
	var disty:int = randi_range(950, 1100)
	enemy.position = Vector2(rand.x * distx + Player.playerPos.x, rand.y * disty + Player.playerPos.y)
	#change enemy spawn position
	get_tree().current_scene.add_child(enemy)
	waveEnemiesRemaining -= 1
	
func NumEnemies() ->int:
	return get_tree().get_nodes_in_group("Enemy").size()
