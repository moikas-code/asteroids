extends BaseEntity
class_name AsteroidEntity
@onready var bounce = %Bounce as Bounce
@onready var screen_wrap = $ScreenWrap

@onready var sprite_2d = %Sprite2D
@export_enum("LARGE","MEDIUM","SMALL") var size = "LARGE" as String



var large_range:int = randi_range(0,2)
var medium_range:int = randi_range(0,3)
var small_range:int = randi_range(0,4)

func _ready()->void:
	set_velocity(Vector2(randi_range(-50,50),randi_range(-50,50)))

func _process(delta):
		handle_sprite(size)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = bounce.bounce(collision_info,velocity)

func handle_sprite(size:String):
	match size:
		"LARGE":
			sprite_2d.texture = \
			load("res://assets/aseprite/asteroid-L-"+str(large_range)+".png")
		"MEDIUM":
			sprite_2d.texture = \
			load("res://assets/aseprite/asteroid-M-"+str(medium_range)+".png")
		"SMALL":
			sprite_2d.texture = \
			load("res://assets/aseprite/asteroid-S-"+str(small_range)+".png")


func _on_hitbox_body_entered(body):
	if body.is_in_group("laser"):
		SignalBus.emit_on_asteroid_destroy(self,size)
		body.queue_free()
		self.queue_free()
