@tool
class_name Unit
extends Area2D

@export var stats: UnitStats : set = set_stats

@onready var skin: Sprite2D = $Visuals/Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var velocity_based_rotation: VelocityBasedRotation = $VelocityBasedRotation
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter

func _ready() -> void:
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)

func set_stats(value: UnitStats) -> void:
	stats = value
	
	# prevent errors if incorrect or no stats values assigned
	if value == null:
		return
	
	# setter func called before export var; double-check scene ready
	if not is_node_ready():
		await ready
	
	skin.region_rect.position = Vector2(stats.skin_coordinates) * Arena.CELL_SIZE

func reset_after_dragging(starting_position: Vector2) -> void:
	velocity_based_rotation.enabled = false
	global_position = starting_position

func _on_drag_started() -> void:
	velocity_based_rotation.enabled = true

func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)

func _on_mouse_entered() -> void:
	if drag_and_drop.dragging:
		return
	
	outline_highlighter.highlight()
	z_index = 1
	
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
	if drag_and_drop.dragging:
		return
	
	outline_highlighter.clear_highlight()
	z_index = 0
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
