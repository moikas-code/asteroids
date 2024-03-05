extends SpawnManager
class_name AsteroidManager

var player:PlayerEntity = null

@export var large_asteroid_scene:PackedScene = null
@export var medium_asteroid_scene:PackedScene = null
@export var small_asteroid_scene:PackedScene = null


@export var max_large_asteroids:int = 10
@export var max_medium_chunks:int = 2
@export var max_small_chunks:int = 3
@export var offset_distance:int = 21
@onready var timer = $Timer
@onready var random_posititon = %RandomPosititon

var large_asteroid_count = 0

func _ready()->void:
	player = get_tree().get_first_node_in_group('player')
	SignalBus.on_asteroid_destroy.connect(on_entity_destroy)
	timer.start()

func on_entity_destroy(entity:CharacterBody2D, type:String):
	var entity_container = NodeExtensions.get_entity_container()
	#print(type)
	match type:
		"LARGE":
			print('5 Points')
			large_asteroid_count -= 1
			for n in range(max_medium_chunks):
				spawn_entity(entity_container, medium_asteroid_scene, "OBJECT", entity.position + Vector2(offset_distance, 0).rotated(deg_to_rad(randi_range(0, 360))), {"size":"MEDIUM"})
	
		"MEDIUM":
			print('10 Points')
			for n in range(max_small_chunks):spawn_entity(entity_container, small_asteroid_scene, "OBJECT", entity.position + Vector2(offset_distance, 0).rotated(deg_to_rad(randi_range(0, 360))),  {"size":"SMALL"})
		"SMALL":
			print('15 Points')
					#

func _on_timer_timeout():
	if game_manager == null:
		return
	game_manager.add_time(1)
	
	player = get_tree().get_first_node_in_group('player')
	if player == null:
		return
	while large_asteroid_count < max_large_asteroids:				
		var enemy_spawn = large_asteroid_scene.instantiate()
		enemy_spawn.global_position = random_posititon.get_random_positon(player)
		add_child(enemy_spawn)
		large_asteroid_count += 1
