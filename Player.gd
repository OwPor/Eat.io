extends Node2D

var size = 1.0
var zoom = 1.0

func _process(_delta):
	$MeshInstance2D.scale.x = lerp($MeshInstance2D.scale.x, size, 0.1)
	$MeshInstance2D.scale.y = lerp($MeshInstance2D.scale.y, size, 0.1)
	
	if Input.is_action_pressed("ui_right"): position.x += 5
	if Input.is_action_pressed("ui_left"): position.x -= 5
	if Input.is_action_pressed("ui_down"): position.y += 5
	if Input.is_action_pressed("ui_up"): position.y -= 5
	
	zoom = 1.0 / log(size + 1)
	$Camera2D.zoom = lerp($Camera2D.zoom, Vector2(zoom, zoom), 0.1)
	
	var foods = get_tree().get_nodes_in_group("Food")
	
	for food in foods:
		if $MeshInstance2D.get_node("Area2D").overlaps_area(food):
			if food.size < size:
				food.queue_free()
				size += 0.1
