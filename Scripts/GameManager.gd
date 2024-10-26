extends Node


var GameRunning = false
var deaths:int = 0

var enemySpawnTimer:float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameRunning:
		enemySpawnTimer += delta
		if enemySpawnTimer >= 1.5:
			enemySpawnTimer = 0
			_spawnEnemy()
	

func StartGame():
	GameRunning = true
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func PlayerDeath():
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
	deaths+=1
	GameRunning = false
	
func _spawnEnemy():
	var enemy = preload("res://Prefabs/Enemy.tscn").instantiate()
	get_tree().current_scene.add_child(enemy)
	#change enemy spawn position
	
func NumEnemies() ->int:
	return get_tree().get_nodes_in_group("Enemy").size()
