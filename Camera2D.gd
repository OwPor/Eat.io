extends Camera2D

@export var player: Node2D
var min_zoom = Vector2(0.1, 0.1)
var max_zoom = Vector2(1.0, 1.0)
var game_area_size = Vector2(5000, 5000)  # Define the game area size

func _process(delta):
	if player:
		position = lerp(position, player.position, 0.1)
		var target_zoom = Vector2(1.0 / log(player.size + 1), 1.0 / log(player.size + 1))
		zoom = lerp(zoom, clamp(target_zoom, min_zoom, max_zoom), 0.1)
		clamp_position()

func clamp_position():
	var viewport_size = get_viewport().size
	var half_viewport_size = viewport_size / 2 * zoom
	position.x = clamp(position.x, -game_area_size.x + half_viewport_size.x, game_area_size.x - half_viewport_size.x)
	position.y = clamp(position.y, -game_area_size.y + half_viewport_size.y, game_area_size.y - half_viewport_size.y)
