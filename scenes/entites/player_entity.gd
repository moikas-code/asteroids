extends BaseEntity

class_name PlayerEntity
@export var laser_scene:PackedScene=null
@onready var sprite_2d = $Sprite2D
@onready var screen_wrap = $ScreenWrap

var mouse_position = null
var movement_speed:float = 150.0

func _ready()->void:
	velocity = Vector2()

func _physics_process(delta):
	
	on_player_ready()
	handle_attack()
	#screen_wrap.wrap_screen(self)
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	rotation_degrees += 90
	
	if Input.is_action_pressed("thrust"):
		if position.distance_to(mouse_position) > 15:
			sprite_2d.set_frame(1)
			velocity = position.direction_to(mouse_position) * movement_speed
	else:
		sprite_2d.set_frame(0)
	move_and_slide()


func on_player_ready()->void:
	SignalBus.emit_on_player_ready(self)

func handle_attack():
	if Input.is_action_just_pressed("shoot"):
		var entity_container = NodeExtensions.get_entity_container()
		if entity_container == null:
			return
		var new_laser = laser_scene.instantiate()
		entity_container.add_child(new_laser)
		new_laser.position = self.position 
		new_laser.rotation_degrees += 0
		new_laser.velocity = self.velocity + new_laser.position.direction_to(mouse_position) * movement_speed


func _on_hitbox_body_entered(body):
	if body ==null:
		return
	if body.is_in_group('asteroid'):
		SignalBus.emit_on_player_death()
		self.queue_free()
