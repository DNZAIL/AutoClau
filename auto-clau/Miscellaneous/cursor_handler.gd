extends Node

const CURSOR_SIZE := Vector2i(16, 16)

const DEFAULT_CURSOR := Vector2i(7, 4)
const POINT_CURSOR := Vector2i(14, 6)
const DRAG_CURSOR := Vector2i(16, 6)

@onready var cursor_texture: Texture2D = preload("uid://b4j1asx3aqggr")

var cursors: Dictionary

# get cursor shapes and set custom cursors for use elsewhere
func _ready() -> void:
	cursors = get_cursor_sprites(cursor_texture)
	change_cursor(DEFAULT_CURSOR, Input.CURSOR_ARROW)
	change_cursor(POINT_CURSOR, Input.CURSOR_POINTING_HAND)
	change_cursor(DRAG_CURSOR, Input.CURSOR_DRAG)
	return

func get_cursor_sprites(texture: Texture2D) -> Dictionary:
	var sprites = {}
	
	var atlas_image = texture.get_image()
	var atlas_size = atlas_image.get_size() / CURSOR_SIZE
	
	for i in atlas_size.x:
		for j in atlas_size.y:
			var rect = Rect2(Vector2i(i, j) * CURSOR_SIZE, CURSOR_SIZE)
			var cursor_image = atlas_image.get_region(rect)
			sprites[Vector2i(i, j)] = ImageTexture.create_from_image(cursor_image)
	
	return sprites

func change_cursor(sprite: Vector2i, shape: Input.CursorShape) -> void:
	Input.set_custom_mouse_cursor(cursors[sprite], shape)
