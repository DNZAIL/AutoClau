class_name TierIcon
extends TextureRect

const TIER_ICONS := {
	1: preload("res://Assets/Sprites/level1.png"),
	2: preload("res://Assets/Sprites/level2.png"),
	3: preload("res://Assets/Sprites/level3.png"),
	4: preload("res://Assets/Sprites/level4.png")
}

@export var stats: UnitStats : set = _set_stats

func _set_stats(value: UnitStats) -> void:
	if stats == value:
		return
	
	stats = value
	
	if stats == null:
		return
	
	if not is_node_ready():
		await ready
	
	if not stats.changed.is_connected(_on_stats_changed):
		stats.changed.connect(_on_stats_changed)
	_on_stats_changed()

func _on_stats_changed() -> void:
	texture = TIER_ICONS[stats.tier]
