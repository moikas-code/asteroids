extends ObjectEntity2D
class_name ProjectileEntity
@onready var timer:Timer = %Timer
@export_range(0.0,10.0) var despawn_time:float = 2.5


func _ready():
	set_velocity(Vector2(200,200))
	timer.timeout.connect(despawn)

	
	
func _physics_process(delta):
	move_and_slide()

func despawn()->void:
	self.queue_free()
