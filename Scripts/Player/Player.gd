extends CharacterBody2D

class_name Player

@export var controller : CharacterBody2D

@export var SPEED: float = 2000

@export var dashPower: float = 100

@export var health = 999

var useable = "res://Prefabs/Explosion.tscn"

var score:int = 0

static var playerPos: Vector2

var dodgeTimer:float = 0
var dodgeTimeGap:float = .2
var shouldDodge:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	_updateHud()
		
	_spawnBullets(delta)
	if Input.is_action_just_pressed("Use"):
		if useable != null:
			Use(useable)
		
		
	_iFrames(delta)
	
	var direction = _movement()
	_dodge(direction, delta)
	controller.move_and_slide()
	playerPos = controller.position
	
	
	if health <= 0:
		GameManager.PlayerDeath()
	
func Use(path: String):
	var item:Node2D = load(path).instantiate()
	#item.position = playerPos
	add_child(item)


func _updateHud():
	$CanvasLayer/Hud/WaveLabel.text = str("Wave: ", GameManager.waveNumber)
	$"CanvasLayer/Hud/Score Label".text = str("\tScore: ", score)

var BulletSpawnTimer = 0
var BulletSpawnFrequency = 0.5
func _spawnBullets(delta: float):
	BulletSpawnTimer += delta
	if GameManager.NumEnemies() > 0 and BulletSpawnTimer >= BulletSpawnFrequency:
		var bullet = preload("res://Prefabs/Bullet.tscn").instantiate()
		bullet.position = playerPos
		get_tree().current_scene.add_child(bullet)
		BulletSpawnTimer = 0

var iframes:float = 3
var invincible:bool = false
var frameTimer: float = 0
func _iFrames(delta: float):
	if invincible == true:
		frameTimer += delta
		$Sprite2D.modulate = Color("white", sin((frameTimer * 45)))
	if frameTimer > iframes:
		invincible = false
		$Sprite2D.modulate = Color("white",1)
		frameTimer = 0
	
func _movement() -> Vector2:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction:
		controller.velocity = direction * SPEED
	else:
		controller.velocity.x = move_toward(controller.velocity.x, 0, SPEED)
		controller.velocity.y = move_toward(controller.velocity.y, 0, SPEED)
	
	return direction

func _dodge(direction : Vector2, delta:float):
	if direction.length() > 0 and !shouldDodge and Input.is_action_just_pressed("dodge"):
		shouldDodge = true
	if shouldDodge:
		controller.velocity += direction * dashPower
		dodgeTimer += delta
	if dodgeTimer >= dodgeTimeGap:
		shouldDodge = false
		dodgeTimer = 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if !invincible and area.is_in_group("Enemy"):
		health -= 1
		invincible = true
