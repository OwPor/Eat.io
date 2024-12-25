extends Node2D

@export var food: PackedScene
@export var initial_food_count: int = 500
@export var spawn_interval: float = 5.0
@export var max_food_count: int = 1000
@export var spawn_area_size: int = 5000

func _ready():
	randomize()
	for i in range(initial_food_count):
		spawn_food()
	
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()

func spawn_food():
	if get_tree().get_nodes_in_group("Food").size() < max_food_count:
		var f = food.instantiate()
		add_child(f)
		f.position.x = randf_range(-spawn_area_size, spawn_area_size)
		f.position.y = randf_range(-spawn_area_size, spawn_area_size)

func _on_Timer_timeout():
	spawn_food()
